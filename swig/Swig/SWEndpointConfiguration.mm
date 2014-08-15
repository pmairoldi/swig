//
//  SWEndpointConfiguration.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWEndpointConfiguration.h"

@implementation SWEndpointConfiguration

-(instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _uaConfig = [SWUserAgentConfiguration new];
    _logConfig = [SWLogConfiguration new];
    _medConfig = [SWMediaConfiguration new];
    
    return self;
}

-(pj::EpConfig)config {
    
    pj::EpConfig config;
    config.uaConfig = self.uaConfig.config;
    config.logConfig = self.logConfig.config;
    config.medConfig = self.medConfig.config;
    
    return config;
}

@end
