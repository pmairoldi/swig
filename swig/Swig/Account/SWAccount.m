//
//  SWAccount.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-21.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWAccount.h"
#import "SWAccountConfiguration.h"
#import "SWEndpoint.h"
#import "SWCall.h"
#import "SWUriFormatter.h"
#import "NSString+PJString.h"

#import "pjsua.h"

typedef void (^SWIncomingCallBlock)(SWCall *call);
typedef void (^SWStateChangeBlock)(SWAccountState state);

@interface SWAccount ()

@property (nonatomic, strong) SWAccountConfiguration *configuration;
@property (nonatomic, strong) NSMutableArray *calls; //more than one call can have value of -1
@property (nonatomic, copy) SWIncomingCallBlock incomingCallBlock;
@property (nonatomic, copy) SWStateChangeBlock stateChangeBlock;

@end

@implementation SWAccount

-(instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _calls = [NSMutableArray new];
    
    return self;
}

-(void)dealloc {
    
}

-(void)setAccountId:(NSInteger)accountId {
    
    _accountId = accountId;
}

-(void)setAccountState:(SWAccountState)accountState {
    
    [self willChangeValueForKey:@"accountState"];
    _accountState = accountState;
    [self didChangeValueForKey:@"accountState"];
    
    if (self.stateChangeBlock) {
        self.stateChangeBlock(self.accountState);
    }
}

-(void)setAccountConfiguration:(SWAccountConfiguration *)accountConfiguration {
    
    [self willChangeValueForKey:@"accountConfiguration"];
    _accountConfiguration = accountConfiguration;
    [self didChangeValueForKey:@"accountConfiguration"];
}

-(void)configure:(SWAccountConfiguration *)configuration completionHandler:(void(^)(NSError *error))handler {
    
    self.accountConfiguration = configuration;
    
    if (!self.accountConfiguration.address) {
        self.accountConfiguration.address = [SWAccountConfiguration addressFromUsername:self.accountConfiguration.username domain:self.accountConfiguration.domain];
    }
    
    NSString *tcpSuffix = @"";
    
    if ([[SWEndpoint sharedInstance] hasTCPConfiguration]) {
        tcpSuffix = @";transport=TCP";
    }
    
    pjsua_acc_config acc_cfg;
    pjsua_acc_config_default(&acc_cfg);
    
    acc_cfg.id = [[SWUriFormatter sipUri:[self.accountConfiguration.address stringByAppendingString:tcpSuffix]] pjString];
    acc_cfg.reg_uri = [[SWUriFormatter sipUri:[self.accountConfiguration.domain stringByAppendingString:tcpSuffix]] pjString];
    acc_cfg.register_on_acc_add = self.accountConfiguration.registerOnAdd ? PJ_TRUE : PJ_FALSE;;
    acc_cfg.publish_enabled = self.accountConfiguration.publishEnabled ? PJ_TRUE : PJ_FALSE;
    acc_cfg.reg_timeout = 600; //TODO test if bg stays alive
    
    acc_cfg.cred_count = 1;
    acc_cfg.cred_info[0].scheme = [self.accountConfiguration.authScheme pjString];
    acc_cfg.cred_info[0].realm = [self.accountConfiguration.authRealm pjString];
    acc_cfg.cred_info[0].username = [self.accountConfiguration.username pjString];
    acc_cfg.cred_info[0].data_type = PJSIP_CRED_DATA_PLAIN_PASSWD;
    acc_cfg.cred_info[0].data = [self.accountConfiguration.password pjString];
    
    if (!self.accountConfiguration.proxy) {
        acc_cfg.proxy_cnt = 0;
    }
    
    else {
        acc_cfg.proxy_cnt = 1;
        acc_cfg.proxy[0] = [[self.accountConfiguration.proxy stringByAppendingString:tcpSuffix] pjString];
    }
    
    pj_status_t status;
    
    status = pjsua_acc_add(&acc_cfg, PJ_TRUE, &_accountId);
    
    if (status != PJ_SUCCESS) {

        NSError *error = [NSError errorWithDomain:@"Error adding account" code:status userInfo:nil];
        
        if (handler) {
            handler(error);
        }
        
        return;
    }

    if (self.accountConfiguration.registerOnAdd) {
        [self connect:handler];
    }
    
    else {
        
        if (handler) {
            handler(nil);
        }
    }
}

-(void)connect:(void(^)(NSError *error))handler {
    
    pj_status_t status;

    status = pjsua_acc_set_registration(self.accountId, PJ_TRUE);
    
    if (status != PJ_SUCCESS) {
        
        NSError *error = [NSError errorWithDomain:@"Error setting registration" code:status userInfo:nil];
        
        if (handler) {
            handler(error);
        }
        
        return;
    }

    status = pjsua_acc_set_online_status(self.accountId, PJ_TRUE);
    
    if (status != PJ_SUCCESS) {
        
        NSError *error = [NSError errorWithDomain:@"Error setting online status" code:status userInfo:nil];
        
        if (handler) {
            handler(error);
        }
        
        return;
    }
    
    if (handler) {
        handler(nil);
    }
}

-(void)disconnect:(void(^)(NSError *error))handler {
    
    pj_status_t status;
    
    status = pjsua_acc_set_online_status(self.accountId, PJ_FALSE);
    
    if (status != PJ_SUCCESS) {
        
        NSError *error = [NSError errorWithDomain:@"Error setting online status" code:status userInfo:nil];
        
        if (handler) {
            handler(error);
        }
        
        return;
    }

    status = pjsua_acc_set_registration(self.accountId, PJ_FALSE);
    
    if (status != PJ_SUCCESS) {
        
        NSError *error = [NSError errorWithDomain:@"Error setting registration" code:status userInfo:nil];
        
        if (handler) {
            handler(error);
        }
        
        return;
    }
    
    if (handler) {
        handler(nil);
    }
}

#pragma Call Management

-(void)addCall:(SWCall *)call {
    
    [self.calls addObject:call];
    
    //TODO:: setup blocks
}

-(void)removeCall:(NSUInteger)callId {
    
    SWCall *call = [self lookupCall:callId];
    
    if (call) {
        [self.calls removeObject:call];
    }
    
    call = nil;
}

-(SWCall *)lookupCall:(NSInteger)callId {
    
    NSArray *array = [self.calls filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(SWCall *call, NSDictionary *bindings) {
        
        if (call.callId == PJSUA_INVALID_ID) {
            return NO;
        }
        
        else if (call.callId == callId) {
            return YES;
        }
        
        else {
            return NO;
        }
    }]];
    
    SWCall *call = [array firstObject]; //TODO add more management
    
    return call;
}

#pragma SWAccountCallbackProtocol Methods

-(void)onIncomingCall:(NSInteger)callId {
    
    SWCall *call = [[SWCall alloc] initWithCallId:callId accountId:_accountId];
    
    [self addCall:call];
    
    if (_incomingCallBlock) {
        _incomingCallBlock(call);
    }
}

-(void)onRegStarted:(BOOL)renew {
    
    SWAccountState accountState;
    
    if (renew) {
        accountState = SWAccountStateConnecting;
    }
    
    else {
        accountState = SWAccountStateDisconnecting;
    }
    
    self.accountState = accountState;
}

-(void)onRegState:(SWAccountState)accountState {
    
    self.accountState = accountState;
}

#pragma Block Parameters
-(void)setIncomingCallBlock:(void(^)(SWCall *call))incomingCallBlock {
    
    _incomingCallBlock = incomingCallBlock;
}

-(void)setStateChangeBlock:(void(^)(SWAccountState state))stateChangeBlock {
    
    _stateChangeBlock = stateChangeBlock;
}

@end