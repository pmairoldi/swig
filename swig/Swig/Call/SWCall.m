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
#import <AVFoundation/AVAudioSession.h>

@interface SWCall ()

@property (nonatomic, strong) UILocalNotification *notification;

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
    
    status = pjsua_call_get_info((int)self.callId, &info);
    
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
}

-(void)setMediaState:(SWMediaState)mediaState {
    
    [self willChangeValueForKey:@"mediaState"];
    _mediaState = mediaState;
    [self didChangeValueForKey:@"mediaState"];
}

-(void)callStateChanged {
    
    pjsua_call_info callInfo;
    pjsua_call_get_info((int)self.callId, &callInfo);
    
    switch (callInfo.state) {
        case PJSIP_INV_STATE_NULL: {
            self.callState = SWCallStateReady;
        } break;
            
        case PJSIP_INV_STATE_CALLING:
        case PJSIP_INV_STATE_INCOMING: {
            self.callState = SWCallStateCalling;
        } break;
            
        case PJSIP_INV_STATE_EARLY:
        case PJSIP_INV_STATE_CONNECTING: {
//            [self startRingback];
            self.callState = SWCallStateConnecting;
        } break;
            
        case PJSIP_INV_STATE_CONFIRMED: {
//            [self stopRingback];
            self.callState = SWCallStateConnected;
        } break;
            
        case PJSIP_INV_STATE_DISCONNECTED: {
//            [self stopRingback];
            self.callState = SWCallStateDisconnected;
        } break;
    }
}

-(void)mediaStateChanged {
    
    pjsua_call_info callInfo;
    pjsua_call_get_info((int)self.callId, &callInfo);
    
    if (callInfo.media_status == PJSUA_CALL_MEDIA_ACTIVE || callInfo.media_status == PJSUA_CALL_MEDIA_REMOTE_HOLD) {
        pjsua_conf_connect(callInfo.conf_slot, 0);
        pjsua_conf_connect(0, callInfo.conf_slot);

        //FIX: add if the error shows up all the time
//        NSArray *availableInputs = [[AVAudioSession sharedInstance] availableInputs];
//        AVAudioSessionPortDescription *port = [availableInputs objectAtIndex:0];
//        NSError *portErr = nil;
//        [[AVAudioSession sharedInstance] setPreferredInput:port error:&portErr];
    }
    
    pjsua_call_media_status mediaStatus = callInfo.media_status;
    
    self.mediaState = (SWMediaState)mediaStatus;
}

-(SWAccount *)getAccount {
    
    pjsua_call_info info;
    pjsua_call_get_info((int)self.callId, &info);
    
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

    pj_status_t status;
    NSError *error;
    
    status = pjsua_call_answer((int)self.callId, PJSIP_SC_OK, NULL, NULL);
    
    if (status != PJ_SUCCESS) {
        
        error = [NSError errorWithDomain:@"Error answering up call" code:0 userInfo:nil];
    }
    
    if (handler) {
        handler(error);
    }
}

-(void)hangup:(void(^)(NSError *error))handler {
    
    //TODO add invalid id check and state disconnected check
        
    pj_status_t status;
    NSError *error;
    
    status = pjsua_call_hangup((int)self.callId, 0, NULL, NULL);
    
    if (status != PJ_SUCCESS) {
        
        error = [NSError errorWithDomain:@"Error hanging up call" code:0 userInfo:nil];
    }
    
    if (handler) {
        handler(error);
    }
}

@end
