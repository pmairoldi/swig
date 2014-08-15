//
//  SWUserAgentConfiguration.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#include "pjsua2/endpoint.hpp"
#endif

@interface SWUserAgentConfiguration : NSObject

//getters
#ifdef __cplusplus
-(pj::UaConfig *)config;
#endif
-(NSUInteger)maxCalls;
-(NSUInteger)threadCnt;
-(BOOL)mainThreadOnly;
-(NSArray *)nameserver;
-(NSString *)userAgent;
-(NSArray *)stunServer;
-(BOOL)stunIgnoreFailure;
-(NSInteger)natTypeInSdp;
-(BOOL)mwiUnsolicitedEnabled;

//setters
-(void)setMaxCalls:(NSUInteger)maxCalls;
-(void)setThreadCnt:(NSUInteger)threadCnt;
-(void)setMainThreadOnly:(BOOL)mainThreadOnly;
-(void)setNameserver:(NSArray *)nameserver;
-(void)setUserAgent:(NSString *)userAgent;
-(void)setStunServer:(NSArray *)stunServer;
-(void)setStunIgnoreFailure:(BOOL)stunIgnoreFailure;
-(void)setNatTypeInSdp:(NSInteger)natTypeInSdp;
-(void)setMwiUnsolicitedEnabled:(BOOL)mwiUnsolicitedEnabled;

@end
