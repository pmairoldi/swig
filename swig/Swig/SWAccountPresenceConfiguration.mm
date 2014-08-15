//
//  SWAccountPresenceConfiguration.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWAccountPresenceConfiguration.h"

@implementation SWAccountPresenceConfiguration

-(instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    return self;
}

-(pj::AccountPresConfig)config {
    
    pj::AccountPresConfig config;
    
    return config;
}

@end
