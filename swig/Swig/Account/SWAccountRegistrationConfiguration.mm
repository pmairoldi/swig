//
//  SWAccountRegistrationConfiguration.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWAccountRegistrationConfiguration.h"

@implementation SWAccountRegistrationConfiguration

-(instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    return self;
}

-(pj::AccountRegConfig)config {
    
    pj::AccountRegConfig config;
    
    return config;
}

@end
