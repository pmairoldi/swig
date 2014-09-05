//
//  SWEndpoint.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-20.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWAccount.h"
#import <pjsua.h>
#import "SWRingtone.h"

@class SWEndpointConfiguration, SWAccount, SWCall;

@interface SWEndpoint : NSObject

@property (nonatomic, strong, readonly) SWEndpointConfiguration *endpointConfiguration;
@property (nonatomic, readonly) pj_pool_t *pjPool;
@property (nonatomic, strong, readonly) NSMutableArray *accounts;
@property (nonatomic, strong) SWRingtone *ringtone;

+(instancetype)sharedEndpoint;

-(void)configure:(SWEndpointConfiguration *)configuration completionHandler:(void(^)(NSError *error))handler; //configure and start endpoint
-(BOOL)hasTCPConfiguration;
-(void)start:(void(^)(NSError *error))handler;
-(void)reset:(void(^)(NSError *error))handler; //reset endpoint

-(void)addAccount:(SWAccount *)account;
-(SWAccount *)lookupAccount:(NSInteger)accountId;
-(SWAccount *)firstAccount;

-(void)setAccountStateChangeBlock:(void(^)(SWAccount *account))accountStateChangeBlock;
-(void)setIncomingCallBlock:(void(^)(SWAccount *account, SWCall *call))incomingCallBlock;
-(void)setCallStateChangeBlock:(void(^)(SWAccount *account, SWCall *call))callStateChangeBlock;
-(void)setCallMediaStateChangeBlock:(void(^)(SWAccount *account, SWCall *call))callMediaStateChangeBlock;

@end
