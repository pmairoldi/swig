//
//  SWCall.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-21.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWCallProtocol.h"
#import "pjsua.h"
//TODO: remove call from calls when disconnected
//TODO: move to 2 sublclasses (incoming/outgoing)

@class SWAccount;

typedef NS_ENUM(NSInteger, SWCallState) {
    SWCallStateReady,
    SWCallStateCalling,
    SWCallStateConnecting,
    SWCallStateConnected,
    SWCallStateDisconnected
};

typedef NS_ENUM(NSInteger, SWMediaState) {
    SWMediaStateNone = PJSUA_CALL_MEDIA_NONE,
    SWMediaStateError = PJSUA_CALL_MEDIA_ERROR,
    SWMediaStateActive = PJSUA_CALL_MEDIA_ACTIVE,
    SWMediaStateLocalHold = PJSUA_CALL_MEDIA_LOCAL_HOLD,
    SWMediaStateRemoteHole = PJSUA_CALL_MEDIA_REMOTE_HOLD
};

@interface SWCall : NSObject <SWCallProtocol>

@property (nonatomic, readonly) NSInteger callId;
@property (nonatomic, readonly) NSInteger accountId;
@property (nonatomic, readonly) SWCallState callState;
@property (nonatomic, readonly) SWMediaState mediaState;

-(instancetype)initWithCallId:(NSUInteger)callId accountId:(NSInteger)accountId;
+(instancetype)callWithId:(NSInteger)callId accountId:(NSInteger)accountId;
+(instancetype)callFromAccountId:(NSInteger)accountId;

-(SWAccount *)getAccount;

-(void)answer:(void(^)(NSError *error))handler;
-(void)hangup:(void(^)(NSError *error))handler;

//-(void)setHold:(void(^)(NSError *error))handler;
//-(void)reinvite:(void(^)(NSError *error))handler;
//-(void)transferCall:(NSString *)destination completionHandler:(void(^)(NSError *error))handler;
//-(void)replaceCall:(SWCall *)call completionHandler:(void (^)(NSError *))handler;

-(void)sendDTMF:(NSString *)dtmf handler:(void(^)(NSError *error))handler;

@end
