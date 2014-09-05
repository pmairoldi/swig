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

@interface SWCall ()

@property (nonatomic, strong) UILocalNotification *notification;
@property (nonatomic, strong) SWRingback *ringback;

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
    
    //configure ringback
    
    _ringback = [SWRingback new];

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
        
    [[UIApplication sharedApplication] cancelLocalNotification:_notification];
    
    if (_callState != SWCallStateDisconnected && _callId != PJSUA_INVALID_ID) {
        pjsua_call_hangup((int)_callId, 0, NULL, NULL);
    }
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

-(void)setRingback:(SWRingback *)ringback {
    
    _ringback = ringback;
}

-(void)callStateChanged {
    
    pjsua_call_info callInfo;
    pjsua_call_get_info((int)self.callId, &callInfo);
    
    switch (callInfo.state) {
        case PJSIP_INV_STATE_NULL: {
            self.callState = SWCallStateReady;
        } break;
            
        case PJSIP_INV_STATE_INCOMING: {
            [[SWEndpoint sharedEndpoint].ringtone start];
            self.callState = SWCallStateIncoming;
        } break;
            
        case PJSIP_INV_STATE_CALLING: {
            [self.ringback start]; //TODO probably not needed
            self.callState = SWCallStateCalling;
        } break;
            
        case PJSIP_INV_STATE_EARLY: {
            [self.ringback start];
        } break;
            
        case PJSIP_INV_STATE_CONNECTING: {
            self.callState = SWCallStateConnecting;
        } break;
            
        case PJSIP_INV_STATE_CONFIRMED: {
            [self.ringback stop];
            [[SWEndpoint sharedEndpoint].ringtone stop];
            self.callState = SWCallStateConnected;
        } break;
            
        case PJSIP_INV_STATE_DISCONNECTED: {
            [self.ringback stop];
            [[SWEndpoint sharedEndpoint].ringtone stop];
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
    
    return [[SWEndpoint sharedEndpoint] lookupAccount:info.acc_id];
}

#pragma Call Management

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
    
    pj_status_t status;
    NSError *error;
    
    if (self.callId != PJSUA_INVALID_ID && self.callState != SWCallStateDisconnected) {
        
        status = pjsua_call_hangup((int)self.callId, 0, NULL, NULL);
        
        if (status != PJ_SUCCESS) {
            
            error = [NSError errorWithDomain:@"Error hanging up call" code:0 userInfo:nil];
        }
    }
    
    if (handler) {
        handler(error);
    }
    
    self.ringback = nil;
}

//-(void)setHold:(void(^)(NSError *error))handler;
//-(void)reinvite:(void(^)(NSError *error))handler;
//-(void)transferCall:(NSString *)destination completionHandler:(void(^)(NSError *error))handler;
//-(void)replaceCall:(SWCall *)call completionHandler:(void (^)(NSError *))handler;

-(void)sendDTMF:(NSString *)dtmf handler:(void(^)(NSError *error))handler {
    
    pj_status_t status;
    NSError *error;
    pj_str_t digits = [dtmf pjString];
    
    status = pjsua_call_dial_dtmf((int)self.callId, &digits);

    if (status != PJ_SUCCESS) {
        error = [NSError errorWithDomain:@"Error sending DTMF" code:0 userInfo:nil];
    }
    
    if (handler) {
        handler(error);
    }
}

@end
