//
//  SWAccountCallConfiguration.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#include <pjsua2/account.hpp>
#endif

@interface SWAccountCallConfiguration : NSObject

@property (nonatomic) pjsua_call_hold_type holdType;
@property (nonatomic) pjsua_100rel_use prackUse;
@property (nonatomic) pjsua_sip_timer_use timerUse;
@property (nonatomic) NSUInteger timerMinSESec;
@property (nonatomic) NSUInteger timerSessExpriresSec;

#ifdef __cplusplus
+(instancetype)callConfigurationFromAccountCallConfig:(pj::AccountCallConfig)config;
-(pj::AccountCallConfig)config;
#endif

@end
