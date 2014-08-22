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