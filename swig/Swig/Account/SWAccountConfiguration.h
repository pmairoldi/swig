//
//  SWAccountConfiguration.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWAccountRegistrationConfiguration.h"
#import "SWAccountSipConfiguration.h"
#import "SWAccountCallConfiguration.h"
#import "SWAccountPresenceConfiguration.h"
#import "SWAccountMWIConfiguration.h"
#import "SWAccountNATConfiguration.h"
#import "SWAccountMediaConfiguration.h"
#import "SWAccountVideoConfiguration.h"
#import "SWAuthCredInfo.h"

#ifdef __cplusplus
#include <pjsua2/account.hpp>
#endif

@interface SWAccountConfiguration : NSObject

-(instancetype)initWithURI:(NSString *)uri;

@property (nonatomic) int priority;
@property (nonatomic, strong) NSString *idUri;
@property (nonatomic, strong) SWAccountRegistrationConfiguration *regConfig;
@property (nonatomic, strong) SWAccountSipConfiguration *sipConfig;
@property (nonatomic, strong) SWAccountCallConfiguration *callConfig;
@property (nonatomic, strong) SWAccountPresenceConfiguration *presConfig;
@property (nonatomic, strong) SWAccountMWIConfiguration *mwiConfig;
@property (nonatomic, strong) SWAccountNATConfiguration *natConfig;
@property (nonatomic, strong) SWAccountMediaConfiguration *mediaConfig;
@property (nonatomic, strong) SWAccountVideoConfiguration *videoConfig;

#ifdef __cplusplus
+(instancetype)accountConfigurationFromAccountId:(NSInteger)accountId;
-(pj::AccountConfig)config;
#endif

@end
