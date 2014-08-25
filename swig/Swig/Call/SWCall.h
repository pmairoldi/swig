//
//  SWCall.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-21.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

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

#import "SWCallCallbackProtocol.h"

@interface SWCall : NSObject <SWCallCallbackProtocol>

@property (nonatomic, readonly) NSInteger callId;
@property (nonatomic, readonly) NSInteger accountId;
@property (nonatomic, readonly) SWCallState callState;

-(instancetype)initWithCallId:(NSUInteger)callId accountId:(NSInteger)accountId;
+(instancetype)callWithId:(NSInteger)callId accountId:(NSInteger)accountId;
+(instancetype)callFromAccountId:(NSInteger)accountId;

-(SWAccount *)getAccount;

-(void)setStateChangeBlock:(void(^)(SWCallState state))stateChangeBlock;

-(void)makeCall:(NSString *)destination completionHandler:(void(^)(NSError *error))handler;
-(void)answer:(void(^)(NSError *error))handler;
-(void)hangup:(void(^)(NSError *error))handler;
//-(void)setHold:(void(^)(NSError *error))handler;
//-(void)reinvite:(void(^)(NSError *error))handler;
//-(void)transferCall:(NSString *)destination completionHandler:(void(^)(NSError *error))handler;
//-(void)replaceCall:(SWCall *)call completionHandler:(void (^)(NSError *))handler;

@end
