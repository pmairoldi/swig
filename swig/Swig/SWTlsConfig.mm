//
//  SWTlsConfig.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWTlsConfig.h"

@interface SWTlsConfig ()

@property (nonatomic) pj::TlsConfig *config;

@end

@implementation SWTlsConfig

-(instancetype)init {
    
    pj::TlsConfig *config = new pj::TlsConfig;
    
    return [self initWithConfig:config];
}

-(instancetype)initWithConfig:(pj::TlsConfig *)config {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _config = config;
    
    return self;
}

-(pj::TlsConfig *)config {
    
    return _config;
}

@end
