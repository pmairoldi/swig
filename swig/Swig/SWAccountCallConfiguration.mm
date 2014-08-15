//
//  SWAccountCallConfiguration.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWAccountCallConfiguration.h"

@implementation SWAccountCallConfiguration

-(instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    return self;
}

-(pj::AccountCallConfig)config {
    
    pj::AccountCallConfig config;
    
    return config;
}

@end
