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
    
    pj::AccountCallConfig config;
    return [self initWithAccountCallConfig:config];
}

-(instancetype)initWithAccountCallConfig:(pj::AccountCallConfig)config_ {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    pj::AccountCallConfig config = config_;
    
    _holdType = config.holdType;
    _prackUse = config.prackUse;
    _timerUse = config.timerUse;
    _timerMinSESec = config.timerMinSESec;
    _timerSessExpriresSec = config.timerSessExpiresSec;
    
    return self;
}

+(instancetype)callConfigurationFromAccountCallConfig:(pj::AccountCallConfig)config {
    
    return [[SWAccountCallConfiguration alloc] initWithAccountCallConfig:config];
}

-(pj::AccountCallConfig)config {
    
    pj::AccountCallConfig config;
    config.holdType = self.holdType;
    config.prackUse = self.prackUse;
    config.timerUse = self.timerUse;
    config.timerMinSESec = self.timerMinSESec;
    config.timerSessExpiresSec = self.timerSessExpriresSec;
    
    return config;
}

@end