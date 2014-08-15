//
//  SWAccountNATConfiguration.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWAccountNATConfiguration.h"

@implementation SWAccountNATConfiguration

-(instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    return self;
}

-(pj::AccountNatConfig)config {
    
    pj::AccountNatConfig config;
    
    return config;
}

@end
