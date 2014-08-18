//
//  SWEndpointConfiguration.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWUserAgentConfiguration.h"
#import "SWLogConfiguration.h"
#import "SWMediaConfiguration.h"

#ifdef __cplusplus
#include "pjsua2/endpoint.hpp"
#endif

@interface SWEndpointConfiguration : NSObject

@property (nonatomic, strong) SWUserAgentConfiguration *uaConfig;
@property (nonatomic, strong) SWLogConfiguration *logConfig;
@property (nonatomic, strong) SWMediaConfiguration *medConfig;

#ifdef __cplusplus
-(pj::EpConfig)config;
#endif

@end
