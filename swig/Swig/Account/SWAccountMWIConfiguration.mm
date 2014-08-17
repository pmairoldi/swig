//
//  SWAccountMWIConfiguration.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWAccountMWIConfiguration.h"

@implementation SWAccountMWIConfiguration

-(instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    pj::AccountMwiConfig config;
    _enabled = config.enabled;
    _expirationSec = config.expirationSec;
    
    return self;
}

-(pj::AccountMwiConfig)config {
    
    pj::AccountMwiConfig config;
    config.enabled = self.enabled;
    config.expirationSec = self.expirationSec;
    
    return config;
}

@end
