//
//  SWEndpoint.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-20.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SWEndpoint.h"
#import "SWTransportConfiguration.h"
#import "SWEndpointConfiguration.h"
#import "SWAccount.h"
#import "SWCall.h"
#import "pjsua.h"
#import "NSString+PJString.h"
#import <AFNetworkReachabilityManager.h>

#define KEEP_ALIVE_INTERVAL 600

typedef void (^SWAccountStateChangeBlock)(SWAccount *account);
typedef void (^SWIncomingCallBlock)(SWAccount *account, SWCall *call);
typedef void (^SWCallStateChangeBlock)(SWAccount *account, SWCall *call);
typedef void (^SWCallMediaStateChangeBlock)(SWAccount *account, SWCall *call);

//callback functions

static void SWOnIncomingCall(pjsua_acc_id acc_id, pjsua_call_id call_id, pjsip_rx_data *rdata);

static void SWOnCallMediaState(pjsua_call_id call_id);

static void SWOnCallState(pjsua_call_id call_id, pjsip_event *e);

static void SWOnCallTransferStatus(pjsua_call_id call_id, int st_code, const pj_str_t *st_text, pj_bool_t final, pj_bool_t *p_cont);

static void SWOnCallReplaced(pjsua_call_id old_call_id, pjsua_call_id new_call_id);

static void SWOnRegState(pjsua_acc_id acc_id);

static void SWOnNatDetect(const pj_stun_nat_detect_result *res);

@interface SWEndpoint ()

@property (nonatomic, strong) NSMutableArray *accounts; //TODO change to array?
@property (nonatomic, copy) SWIncomingCallBlock incomingCallBlock;
@property (nonatomic, copy) SWAccountStateChangeBlock accountStateChangeBlock;
@property (nonatomic, copy) SWCallStateChangeBlock callStateChangeBlock;
@property (nonatomic, copy) SWCallMediaStateChangeBlock callMediaStateChangeBlock;

@end

@implementation SWEndpoint

static SWEndpoint *_sharedEndpoint = nil;

+(id)sharedEndpoint {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedEndpoint = [self new];
    });
    
    return _sharedEndpoint;
}

-(instancetype)init {

    if (_sharedEndpoint) {
        return _sharedEndpoint;
    }
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _accounts = [[NSMutableArray alloc] init];

    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(handleEnteredBackground:) name: UIApplicationDidEnterBackgroundNotification object:nil];
    
    // [DDLog addLogger:[DDASLLogger sharedInstance]];
    // [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    // DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    // fileLogger.rollingFrequency = 0;
    // fileLogger.maximumFileSize = 0;
    
    // [DDLog addLogger:fileLogger];

    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        [self performSelectorOnMainThread:@selector(keepAlive) withObject:nil waitUntilDone:YES];
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    return self;
}

-(void)dealloc {
 
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
}

-(void)handleEnteredBackground:(NSNotification *)notification {
    
    UIApplication *application = (UIApplication *)notification.object;
    
    [self performSelectorOnMainThread:@selector(keepAlive) withObject:nil waitUntilDone:YES];
    
    [application setKeepAliveTimeout:KEEP_ALIVE_INTERVAL handler: ^{
        [self performSelectorOnMainThread:@selector(keepAlive) withObject:nil waitUntilDone:YES];
    }];
}

-(void)keepAlive {
    
    //TODO check if endpoint configured
    
    if (!pj_thread_is_registered()) {
        static pj_thread_desc thread_desc;
        static pj_thread_t *thread;
        pj_thread_register("swig", thread_desc, &thread);
    }
    
    for (SWAccount *account in self.accounts) {
    
        if (account.isValid) {
            
            [account connect:^(NSError *error) {
               
                // if (error) DDLogDebug(@"%@",[error description]);
            }];
        }
    
        else {
            
            [account disconnect:^(NSError *error) {
               
                // if (error) DDLogDebug(@"%@",[error description]);
            }];
        }
    }
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
    ua_cfg.max_calls = (unsigned int)self.endpointConfiguration.maxCalls;
    
    log_cfg.level = (unsigned int)self.endpointConfiguration.logLevel;
    log_cfg.console_level = (unsigned int)self.endpointConfiguration.logConsoleLevel;
    log_cfg.log_filename = [self.endpointConfiguration.logFilename pjString];
    log_cfg.log_file_flags = (unsigned int)self.endpointConfiguration.logFileFlags;
    
    media_cfg.clock_rate = (unsigned int)self.endpointConfiguration.clockRate;
    media_cfg.snd_clock_rate = (unsigned int)self.endpointConfiguration.sndClockRate;
    
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
        
        transportConfig.port = (unsigned int)transport.port;
        transportConfig.port_range = (unsigned int)transport.portRange;
        
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
    
    [self.accounts addObject:account];
    
}

-(SWAccount *)lookupAccount:(NSInteger)accountId {
    
    NSUInteger accountIndex = [self.accounts indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        
        SWAccount *account = (SWAccount *)obj;
        
        if (account.accountId == accountId && account.accountId != PJSUA_INVALID_ID) {
            return YES;
        }
        
        return NO;
    }];
    
    if (accountIndex != NSNotFound) {
        return [self.accounts objectAtIndex:accountIndex]; //TODO add more management
    }
    
    else {
        return nil;
    }
}

#pragma Block Parameters

-(void)setAccountStateChangeBlock:(void(^)(SWAccount *account))accountStateChangeBlock {
    
    _accountStateChangeBlock = accountStateChangeBlock;
}

-(void)setIncomingCallBlock:(void(^)(SWAccount *account, SWCall *call))incomingCallBlock {
    
    _incomingCallBlock = incomingCallBlock;
}

-(void)setCallStateChangeBlock:(void(^)(SWAccount *account, SWCall *call))callStateChangeBlock {
    
    _callStateChangeBlock = callStateChangeBlock;
}

-(void)setCallMediaStateChangeBlock:(void(^)(SWAccount *account, SWCall *call))callMediaStateChangeBlock {
    
    _callMediaStateChangeBlock = callMediaStateChangeBlock;
}

#pragma PJSUA Callbacks

static void SWOnRegState(pjsua_acc_id acc_id) {
    
    SWAccount *account = [[SWEndpoint sharedEndpoint] lookupAccount:acc_id];
    
    if (account) {
        
        [account accountStateChanged];
        
        if ([SWEndpoint sharedEndpoint].accountStateChangeBlock) {
            [SWEndpoint sharedEndpoint].accountStateChangeBlock(account);
        }
    }
}

static void SWOnIncomingCall(pjsua_acc_id acc_id, pjsua_call_id call_id, pjsip_rx_data *rdata) {
    
    SWAccount *account = [[SWEndpoint sharedEndpoint] lookupAccount:acc_id];
    
    if (account) {
        
        SWCall *call = [SWCall callWithId:call_id accountId:acc_id];
        
        [account addCall:call];
        
        if ([SWEndpoint sharedEndpoint].incomingCallBlock) {
            [SWEndpoint sharedEndpoint].incomingCallBlock(account, call);
        }
    }
}

static void SWOnCallState(pjsua_call_id call_id, pjsip_event *e) {
    
    pjsua_call_info callInfo;
    pjsua_call_get_info(call_id, &callInfo);
    
    SWAccount *account = [[SWEndpoint sharedEndpoint] lookupAccount:callInfo.acc_id];

    if (account) {
        
        SWCall *call = [account lookupCall:call_id];
    
        [call callStateChanged];
        
        if (call) {
            
            if ([SWEndpoint sharedEndpoint].callStateChangeBlock) {
                [SWEndpoint sharedEndpoint].callStateChangeBlock(account, call);
            }
        }
        
        if (call.callState == SWCallStateDisconnected) {
            
            [call hangup:^(NSError *error) {
                // if (error) DDLogDebug(@"%@", [error description]);
            }];
        }
    }
}

static void SWOnCallMediaState(pjsua_call_id call_id) {
    
    pjsua_call_info callInfo;
    pjsua_call_get_info(call_id, &callInfo);
    
    SWAccount *account = [[SWEndpoint sharedEndpoint] lookupAccount:callInfo.acc_id];
    
    if (account) {
        
        SWCall *call = [account lookupCall:call_id];
        
        [call mediaStateChanged];
        
        if (call) {
            
            if ([SWEndpoint sharedEndpoint].callMediaStateChangeBlock) {
                [SWEndpoint sharedEndpoint].callMediaStateChangeBlock(account, call);
            }
        }
    }
}

//TODO: implement these
static void SWOnCallTransferStatus(pjsua_call_id call_id, int st_code, const pj_str_t *st_text, pj_bool_t final, pj_bool_t *p_cont) {
    
}

static void SWOnCallReplaced(pjsua_call_id old_call_id, pjsua_call_id new_call_id) {
    
}

static void SWOnNatDetect(const pj_stun_nat_detect_result *res){
    
}

@end
