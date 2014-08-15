//
//  SWAccountVideoConfiguration.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWAccountVideoConfiguration.h"

@implementation SWAccountVideoConfiguration

-(instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    return self;
}

-(pj::AccountVideoConfig)config {
    
    pj::AccountVideoConfig config;
    
    return config;
}

@end
