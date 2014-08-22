//
//  SWEndpoint.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-20.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWEndpoint.h"
#import "SWTransportConfiguration.h"
#import "SWEndpointConfiguration.h"
#import "SWAccount.h"

#import "pjsua.h"

#import "NSString+PJString.h"

typedef void (^SWAccountSIncomingCallBlock)(SWAccount *account, SWCall *call);
typedef void (^SWAccountStateChangeBlock)(SWAccount *account, SWAccountState state);

//callback functions

static void SWOnIncomingCall(pjsua_acc_id acc_id, pjsua_call_id call_id, pjsip_rx_data *rdata);

static void SWOnCallMediaState(pjsua_call_id call_id);

static void SWOnCallState(pjsua_call_id call_id, pjsip_event *e);

static void SWOnCallTransferStatus(pjsua_call_id call_id, int st_code, const pj_str_t *st_text, pj_bool_t final, pj_bool_t *p_cont);

static void SWOnCallReplaced(pjsua_call_id old_call_id, pjsua_call_id new_call_id);

static void SWOnRegState(pjsua_acc_id acc_id);

static void SWOnNatDetect(const pj_stun_nat_detect_result *res);

@interface SWEndpoint ()

@property (nonatomic, strong) NSMutableDictionary *accounts; //TODO change to array?
@property (nonatomic, copy) SWAccountSIncomingCallBlock accountIncomingCallBlock;
@property (nonatomic, copy) SWAccountStateChangeBlock accountStateChangeBlock;

@end

@implementation SWEndpoint

static SWEndpoint *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+(id)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];
    });
    
    return SINGLETON;
}

#pragma mark - Life Cycle

+(id) allocWithZone:(NSZone *)zone {
    return [self sharedInstance];
}

+(id)copyWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

+(id)mutableCopyWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

-(id)copy {
    return [[SWEndpoint alloc] init];
}

-(id)mutableCopy {
    return [[SWEndpoint alloc] init];
}

-(id)init {
    
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _accounts = [NSMutableDictionary dictionary];
    
    return self;
}

-(void)dealloc {
    
}

-(void)setEndpointConfiguration:(SWEndpointConfiguration *)endpointConfiguration {
    
    [self willChangeValueForKey:@"endpointConfiguration"];
    _endpointConfiguration = endpointConfiguration;
    [self didChangeValueForKey:@"endpointConfiguration"];
}

-(void)configure:(SWEndpointConfiguration *)configuration completionHandler:(void(^)(NSError *error))handler {
    
    //TODO add lock to this method
    
    self.endpointConfiguration = configuration;
    
    pj_status_t status;
    
    status = pjsua_create();
    
    if (status != PJ_SUCCESS) {
        
        NSError *error = [NSError errorWithDomain:@"Error creating pjsua" code:status userInfo:nil];
        
        if (handler) {
            handler(error);
        }
        
        return;
    }
    
    pjsua_config ua_cfg;
    pjsua_logging_config log_cfg;
    pjsua_media_config media_cfg;
    
    pjsua_config_default(&ua_cfg);
    pjsua_logging_config_default(&log_cfg);
    pjsua_media_config_default(&media_cfg);
    
    ua_cfg.cb.on_incoming_call = &SWOnIncomingCall;
    ua_cfg.cb.on_call_media_state = &SWOnCallMediaState;
    ua_cfg.cb.on_call_state = &SWOnCallState;
    ua_cfg.cb.on_call_transfer_status = &SWOnCallTransferStatus;
    ua_cfg.cb.on_call_replaced = &SWOnCallReplaced;
    ua_cfg.cb.on_reg_state = &SWOnRegState;
    ua_cfg.cb.on_nat_detect = &SWOnNatDetect;
    ua_cfg.max_calls = self.endpointConfiguration.maxCalls;
    
    log_cfg.level = self.endpointConfiguration.logLevel;
    log_cfg.console_level = self.endpointConfiguration.logConsoleLevel;
    log_cfg.log_filename = [self.endpointConfiguration.logFilename pjString];
    log_cfg.log_file_flags = self.endpointConfiguration.logFileFlags;
    
    media_cfg.clock_rate = self.endpointConfiguration.clockRate;
    media_cfg.snd_clock_rate = self.endpointConfiguration.sndClockRate;
    
    status = pjsua_init(&ua_cfg, &log_cfg, &media_cfg);
    
    if (status != PJ_SUCCESS) {
        
        NSError *error = [NSError errorWithDomain:@"Error initializing pjsua" code:status userInfo:nil];
        
        if (handler) {
            handler(error);
        }
        
        return;
    }
    
    //TODO autodetect port by checking transportId
    
    for (SWTransportConfiguration *transport in self.endpointConfiguration.transportConfigurations) {

        pjsua_transport_config transportConfig;
        
        pjsua_transport_config_default(&transportConfig);
        
        transportConfig.port = transport.port;
        transportConfig.port_range = transport.portRange;
        
        pjsip_transport_type_e transportType = (pjsip_transport_type_e)transport.transportType;
        
        status = pjsua_transport_create(transportType, &transportConfig, NULL);
        
        if (status != PJ_SUCCESS) {
            
            NSError *error = [NSError errorWithDomain:@"Error creating pjsua transport" code:status userInfo:nil];
            
            if (handler) {
                handler(error);
            }
            
            return;
        }
    }

    [self start:handler];
}

-(BOOL)hasTCPConfiguration {
    
    NSUInteger index = [self.endpointConfiguration.transportConfigurations indexOfObjectPassingTest:^BOOL(SWTransportConfiguration *obj, NSUInteger idx, BOOL *stop) {
        
        if (obj.transportType == SWTransportTypeTCP || obj.transportType == SWTransportTypeTCP6) {
            return YES;
            *stop = YES;
        }
        
        else {
            return NO;
        }
    }];
    
    if (index == NSNotFound) {
        return NO;
    }
    
    else {
        return YES;
    }
}

-(void)start:(void(^)(NSError *error))handler {

    pj_status_t status = pjsua_start();
    
    if (status != PJ_SUCCESS) {
        
        NSError *error = [NSError errorWithDomain:@"Error starting pjsua" code:status userInfo:nil];
        
        if (handler) {
            handler(error);
        }
        
        return;
    }
    
    if (handler) {
        handler(nil);
    }
}

-(void)reset:(void(^)(NSError *error))handler {
    
    //TODO shutdown agent correctly. stop all calls, destroy all accounts
    
    pj_status_t status = pjsua_destroy();
    
    if (status != PJ_SUCCESS) {
        
        NSError *error = [NSError errorWithDomain:@"Error destroying pjsua" code:status userInfo:nil];
        
        if (handler) {
            handler(error);
        }
        
        return;
    }
    
    if (handler) {
        handler(nil);
    }
    
}

#pragma Account Management

-(void)addAccount:(SWAccount *)account {
    
    [self.accounts setObject:account forKey:@(account.accountId)];
    
    __weak SWAccount *weak_account = account;
    
    [account setIncomingCallBlock:^(SWCall *call) {
        
        SWAccount *strong_account = weak_account;
        
        if (self.accountIncomingCallBlock) {
            self.accountIncomingCallBlock(strong_account, call);
        }
    }];
    
    [account setStateChangeBlock:^(SWAccountState state) {
        
        SWAccount *strong_account = weak_account;

        if (self.accountStateChangeBlock) {
            self.accountStateChangeBlock(strong_account, state);
        }
    }];
}

-(SWAccount *)lookupAccount:(NSInteger)accountId {
    
    if ([[self.accounts allKeys] containsObject:@(accountId)]) {
        return [self.accounts objectForKey:@(accountId)];
    }
    
    else {
        return nil;
    }
}

#pragma Block Parameters

-(void)setAccountIncomingCallBlock:(void(^)(SWAccount *account, SWCall *call))accountIncomingCallBlock {
    
    _accountIncomingCallBlock = accountIncomingCallBlock;
}

-(void)setAccountStateChangeBlock:(void(^)(SWAccount *account, SWAccountState state))accountStateChangeBlock {
    
    _accountStateChangeBlock = accountStateChangeBlock;
}

#pragma PJSUA Callbacks 

static void SWOnIncomingCall(pjsua_acc_id acc_id, pjsua_call_id call_id, pjsip_rx_data *rdata) {
    
}

static void SWOnCallMediaState(pjsua_call_id call_id) {
    
}

static void SWOnCallState(pjsua_call_id call_id, pjsip_event *e) {
    
}

static void SWOnCallTransferStatus(pjsua_call_id call_id, int st_code, const pj_str_t *st_text, pj_bool_t final, pj_bool_t *p_cont) {
    
}

static void SWOnCallReplaced(pjsua_call_id old_call_id, pjsua_call_id new_call_id) {
    
}

static void SWOnRegState(pjsua_acc_id acc_id) {
    
}

static void SWOnNatDetect(const pj_stun_nat_detect_result *res){
    
}

@end
