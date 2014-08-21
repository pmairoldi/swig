//
//  SWAccount.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-21.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SWAccountConfiguration, SWCall;

typedef NS_ENUM(NSInteger, SWAccountState) {
    SWAccountStateOffline,
    SWAccountStateInvalid,
    SWAccountStateConnecting,
    SWAccountStateConnected,
    SWAccountStateDisconnecting
};

#import "SWAccountCallbackProtocol.h"

@interface SWAccount : NSObject <SWAccountCallbackProtocol>

@property (nonatomic, readonly) NSInteger accountId;
@property (nonatomic, readonly) SWAccountState accountState;

-(void)configure:(SWAccountConfiguration *)configuration completionHandler:(void(^)(NSError *error))handler; //configure and add account
-(void)connect:(void(^)(NSError *error))handler;
-(void)disconnect:(void(^)(NSError *error))handler;

-(void)setIncomingCallBlock:(void(^)(SWCall *call))incomingCallBlock;
-(void)setStateChangeBlock:(void(^)(SWAccountState state))stateChangeBlock;

@end
