//
//  SWAccountCallbackProtocol.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWAccount.h"

@protocol SWAccountCallbackProtocol <NSObject>

-(void)onIncomingCall:(NSInteger)callId;
-(void)onRegStarted:(BOOL)renew;
-(void)onRegState:(SWAccountState)accountState;

@end
