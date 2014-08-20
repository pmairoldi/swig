//
//  SWAccountCallbackProtocol.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWAccountParam.h"

@protocol SWAccountCallbackProtocol <NSObject>

-(void)onIncomingCall:(SWOnIncomingCallParam *)param;
-(void)onRegStarted:(SWOnRegStartedParam *)param;
-(void)onRegState:(SWOnRegStateParam *)param;
-(void)onIncomingSubscribe:(SWOnIncomingSubscribeParam *)param;
-(void)onInstantMessage:(SWOnInstantMessageParam *)param;
-(void)onInstantMessageStatus:(SWOnInstantMessageStatusParam *)param;
-(void)onTypingIndication:(SWOnTypingIndicationParam *)param;
-(void)onMwiInfo:(SWOnMwiInfoParam *)param;

@end
