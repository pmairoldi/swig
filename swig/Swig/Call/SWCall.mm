//
//  SWCall.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-21.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWCall.h"
#import "pjsua2.hpp"
#import "SwigCall.h"
#import "SWAccount.h"
#import "SwigAccount.h"
#import "NSString+String.h"
#import "NSError+Error.h"
#import "SWUriFormatter.h"

typedef void (^SWStateChangeBlock)(SWCallState state);

@interface SWCall ()

@property (nonatomic) sw::Call *call;
@property (nonatomic, copy) SWStateChangeBlock stateChangeBlock;

@end

@implementation SWCall

-(instancetype)init {
    
    NSAssert(NO, @"never call init directly use init with call id");
    
    return nil;
}

-(instancetype)initWithCallId:(NSUInteger)callId account:(SWAccount *)account {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    self.call = new sw::Call(*(sw::Account::lookup(account.accountId)), callId);
    self.callId = _call->getId();
    self.account = account;
    self.callState = SWCallStateReady;
    
    return self;
}

+(instancetype)callWithId:(NSInteger)callId account:(SWAccount *)account {
    
    SWCall *call = [[SWCall alloc] initWithCallId:callId account:account];
    
    [account addCall:call];
    
    return call;
}

+(instancetype)callFromAccount:(SWAccount *)account {
    
    return [self callWithId:PJSUA_INVALID_ID account:account];
}

-(void)dealloc {
    
    //TODO hangup before
    if (self.call) {
        delete self.call;
    }
}

-(void)setAccount:(SWAccount *)account {
    
    [self willChangeValueForKey:@"account"];
    _account = account;
    [self didChangeValueForKey:@"account"];
}
-(void)setCallId:(NSInteger)callId {
    
    [self willChangeValueForKey:@"callId"];
    _callId = callId;
    [self didChangeValueForKey:@"callId"];
}

-(void)setCallState:(SWCallState)callState {
    
    [self willChangeValueForKey:@"callState"];
    _callState = callState;
    [self didChangeValueForKey:@"callState"];
    
    if (self.stateChangeBlock) {
        self.stateChangeBlock(self.callState);
    }
}

#pragma Call Management

-(void)makeCall:(NSString *)destination completionHandler:(void(^)(NSError *error))handler {
    
    try {
        
        pj::CallOpParam param;
        param.statusCode = PJSIP_SC_OK;
        
        self.call->makeCall(*[[SWUriFormatter sipUri:destination] CPPString], param);
        self.callState = SWCallStateCalling;
        
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

-(void)answer:(void(^)(NSError *error))handler {
    
    try {
        
        pj::CallOpParam param;
        param.statusCode = PJSIP_SC_OK;
        
        self.call->answer(param);
        
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

-(void)hangup:(void(^)(NSError *error))handler {
    
    try {
        
        pj::CallOpParam param;
      
        if (self.callState == SWCallStateReady || self.callState == SWCallStateCalling) {
            param.statusCode = (pjsip_status_code)0;
        }

        if (self.callState != SWCallStateDisconnected) {
            self.call->hangup(param);
        }
        
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

#pragma SWCallCallbackProtocol

-(void)onCallState:(SWCallState)callState {
    
    //TODO handle ringing
    
    self.callState = callState;

    if (self.callState == SWCallStateDisconnected) {
        [self.account removeCall:self];
    }
}

#pragma Block Parameters

-(void)setStateChangeBlock:(void(^)(SWCallState state))stateChangeBlock {
    
    _stateChangeBlock = stateChangeBlock;
}

@end
