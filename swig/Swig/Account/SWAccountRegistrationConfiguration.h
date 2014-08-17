//
//  SWAccountRegistrationConfiguration.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#include <pjsua2/account.hpp>
#endif

@interface SWAccountRegistrationConfiguration : NSObject

@property (nonatomic, strong) NSString *registrarUri;
@property (nonatomic) BOOL registerOnAdd;
@property (nonatomic, strong) NSArray *headers;
@property (nonatomic) NSUInteger timeoutSec;
@property (nonatomic) NSUInteger retryIntervalSec;
@property (nonatomic) NSUInteger firstRetryIntervalSec;
@property (nonatomic) NSUInteger delayBeforeRefreshSec;
@property (nonatomic) BOOL dropCallsOnFail;
@property (nonatomic) NSUInteger unregWaitSec;
@property (nonatomic) NSUInteger proxyUse;

#ifdef __cplusplus
+(instancetype)registrationConfigurationFromAccountRegConfig:(pj::AccountRegConfig)config;
-(pj::AccountRegConfig)config;
#endif

@end
