//
//  SWAccount.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-21.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWAccount.h"
#import "NSError+Error.h"
#import "SWAccountConfiguration.h"
#import "SWAccountConfiguration+AccountConfig.h"
#include "SwigAccount.h"
#include "pjsua2.hpp"
#import "SWEndpoint.h"
#import "SWCall.h"

typedef void (^SWIncomingCallBlock)(SWCall *call);
typedef void (^SWStateChangeBlock)(SWAccountState state);

@interface SWAccount ()

@property (nonatomic) sw::Account *account;
@property (nonatomic, strong) SWAccountConfiguration *configuration;
@property (nonatomic, strong) NSMutableDictionary *calls;
@property (nonatomic, copy) SWIncomingCallBlock incomingCallBlock;
@property (nonatomic, copy) SWStateChangeBlock stateChangeBlock;

@end

@implementation SWAccount

-(instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _calls = [NSMutableDictionary dictionary];
    
    return self;
}

-(void)dealloc {
  
    if (_account) {
        delete _account;
    }
}

-(sw::Account *)account {
    
    if (!_account) {
        
        _account = new sw::Account;
    }
    
    return _account;
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

-(void)configure:(SWAccountConfiguration *)configuration completionHandler:(void(^)(NSError *error))handler {
    
    try {
        
        pj::AccountConfig *config = [configuration toAccountConfig];
        
        self.account->create(*config);
        self.accountId = self.account->getId();
        
        [[SWEndpoint sharedInstance] addAccount:self];
        
    } catch(pj::Error &err) {
        
        NSError *error = [NSError errorWithError:&err];
        
        if (handler) {
            handler(error);
        }
    }
    
    if (handler) {
        handler(nil);
    }
}

-(void)connect:(void(^)(NSError *error))handler {
   
    try {
        
        self.account->setRegistration(true);
        
        pj::PresenceStatus presence;
        presence.status = PJSUA_BUDDY_STATUS_ONLINE;
        
        self.account->setOnlineStatus(presence);
        
    } catch(pj::Error &err) {
        
        NSError *error = [NSError errorWithError:&err];
        
        if (handler) {
            handler(error);
        }
    }
    
    if (handler) {
        handler(nil);
    }
}

-(void)disconnect:(void(^)(NSError *error))handler {
    
    try {
        
        pj::PresenceStatus presence;
        presence.status = PJSUA_BUDDY_STATUS_OFFLINE;
        
        self.account->setOnlineStatus(presence);
        
        self.account->setRegistration(false);

    } catch(pj::Error &err) {
        
        NSError *error = [NSError errorWithError:&err];
        
        if (handler) {
            handler(error);
        }
    }
    
    if (handler) {
        handler(nil);
    }
}

#pragma Call Management 

-(void)addCall:(SWCall *)call {
    
    [self.calls setObject:call forKey:@(call.callId)];
    
    //TODO:: setup blocks
}

-(void)removeCall:(SWCall *)call {
    
    if ([self lookupCall:call.callId]) {
        [self.calls removeObjectForKey:@(call.callId)];
    }
    
    call = nil;
}

-(SWCall *)lookupCall:(NSInteger)callId {
    
    if ([[self.calls allKeys] containsObject:@(callId)]) {
        return [self.calls objectForKey:@(callId)];
    }
    
    else {
        return nil;
    }
}

#pragma SWAccountCallbackProtocol Methods

-(void)onIncomingCall:(NSInteger)callId {
    
    SWCall *call = [SWCall callWithId:callId account:self];
    
    if (self.incomingCallBlock) {
        self.incomingCallBlock(call);
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