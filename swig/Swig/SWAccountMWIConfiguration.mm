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
    
    return self;
}

-(pj::AccountMwiConfig)config {
    
    pj::AccountMwiConfig config;
    
    return config;
}

@end
