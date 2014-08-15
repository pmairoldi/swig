//
//  SWAccountMediaConfiguration.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWAccountMediaConfiguration.h"

@implementation SWAccountMediaConfiguration

-(instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    return self;
}

-(pj::AccountMediaConfig)config {
    
    pj::AccountMediaConfig config;
    
    return config;
}

@end
