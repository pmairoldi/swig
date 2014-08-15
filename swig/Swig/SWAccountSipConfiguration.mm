//
//  SWAccountSipConfiguration.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWAccountSipConfiguration.h"

@implementation SWAccountSipConfiguration

-(instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    return self;
}

-(pj::AccountSipConfig)config {
    
    pj::AccountSipConfig config;
    
    return config;
}

@end
