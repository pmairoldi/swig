//
//  SWCall.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-21.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWCall.h"
#import "SWAccount.h"
#import "SWEndpoint.h"
#import "SWUriFormatter.h"
#import "NSString+PJString.h"
#import "pjsua.h"

typedef void (^SWStateChangeBlock)(SWCallState state);

@interface SWCall ()

@property (nonatomic, strong) UILocalNotification *notification;
@property (nonatomic, copy) SWStateChangeBlock stateChangeBlock;

@end

@implementation SWCall

-(instancetype)init {
    
    NSAssert(NO, @"never call init directly use init with call id");
    
    return nil;
}

-(instancetype)initWithCallId:(NSUInteger)callId accountId:(NSInteger)accountId {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _callState = SWCallStateReady;
    _callId = callId;
    _accountId = accountId;
    
    return self;
}

+(instancetype)callWithId:(NSInteger)callId accountId:(NSInteger)accountId {
    
    SWCall *call = [[SWCall alloc] initWithCallId:callId accountId:accountId];
        
    [call createLocalNotification];
    
    return call;
}

+(instancetype)callFromAccountId:(NSInteger)accountId {

    SWCall *call = [SWCall callWithId:PJSUA_INVALID_ID accountId:accountId];

    return call;
}

-(void)createLocalNotification {
    
    _notification = [[UILocalNotification alloc] init];
    _notification.repeatInterval = 0;
    
    pj_status_t status;
    
    pjsua_call_info info;
    
    status = pjsua_call_get_info(self.callId, &info);
    
    if (status == PJ_TRUE) {
        _notification.alertBody = [NSString stringWithFormat:@"Incoming call from %@", [NSString stringWithPJString:info.remote_contact]];
    }
    
    else {
        _notification.alertBody = @"Incoming call";
    }
    
    _notification.alertAction = @"Activate app";
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:_notification];
}

-(void)dealloc {
    
    //TODO hangup before
    
    [[UIApplication sharedApplication] cancelLocalNotification:_notification];
}

-(void)setCallId:(NSInteger)callId {
    
    [self willChangeValueForKey:@"callId"];
    _callId = callId;
    [self didChangeValueForKey:@"callId"];
}

-(void)setAccountId:(NSInteger)accountId {
    
    [self willChangeValueForKey:@"callId"];
    _accountId = accountId;
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

-(SWAccount *)getAccount {
    
    pjsua_call_info info;
    pjsua_call_get_info(self.callId, &info);
    
   return [[SWEndpoint sharedInstance] lookupAccount:info.acc_id];
}

#pragma Call Management

-(void)makeCall:(NSString *)destination completionHandler:(void(^)(NSError *error))handler {
    
//    try {
//        
//        pj::CallOpParam param(true);
//        param.statusCode = PJSIP_SC_OK;
//        
//        self.call->makeCall(*[[SWUriFormatter sipUri:destination fromAccount:[self getAccount]] CPPString], param);
//        self.callState = SWCallStateCalling;
//        
//    } catch(pj::Error &err) {
//        
//        NSError *error = [NSError errorWithError:&err];
//        
//        if (handler) {
//            handler(error);
//        }
//    }
//    
//    if (handler) {
//        handler(nil);
//    }
}

-(void)answer:(void(^)(NSError *error))handler {
    
//    try {
//        
//        pj::CallOpParam param;
//        param.statusCode = PJSIP_SC_OK;
//        
//        self.call->answer(param);
//        
//    } catch(pj::Error &err) {
//        
//        NSError *error = [NSError errorWithError:&err];
//        
//        if (handler) {
//            handler(error);
//        }
//    }
//    
//    if (handler) {
//        handler(nil);
//    }
}

-(void)hangup:(void(^)(NSError *error))handler {
    
//    try {
//        
//        pj::CallOpParam param;
//        
//        if (self.callState == SWCallStateReady || self.callState == SWCallStateCalling) {
//            param.statusCode = PJSIP_SC_DECLINE; //TODO fix busy
//        }
//        
//        if (self.callState != SWCallStateDisconnected) {
//            self.call->hangup(param); //FIX error with hangup
//        }
//        
//    } catch(pj::Error &err) {
//        
//        NSError *error = [NSError errorWithError:&err];
//        
//        if (handler) {
//            handler(error);
//        }
//    }
//    
//    if (handler) {
//        handler(nil);
//    }
}

#pragma SWCallCallbackProtocol

-(void)onCallState:(SWCallState)callState {
    
    //TODO handle ringing
    
    self.callState = callState;
    
    switch (self.callState) {
      
        case SWCallStateReady:
            
            break;
        case SWCallStateCalling:
            
            break;
        case SWCallStateConnecting:
            
            break;
            
        case SWCallStateConnected:
            
            break;
            
        case SWCallStateDisconnected:

            [[self getAccount] removeCall:self.callId];
            
            break;
    }
}

#pragma Block Parameters

-(void)setStateChangeBlock:(void(^)(SWCallState state))stateChangeBlock {
    
    _stateChangeBlock = stateChangeBlock;
}

@end
