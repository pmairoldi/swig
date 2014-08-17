//
//  SWAccountPresenceConfiguration.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWAccountPresenceConfiguration.h"
#import "NSString+String.h"
#import "NSArray+SipHeaderVector.h"

@implementation SWAccountPresenceConfiguration

-(instancetype)init {
    
    pj::AccountPresConfig config;
    return [self initWithAccountPresConfig:config];
}

-(instancetype)initWithAccountPresConfig:(pj::AccountPresConfig)config {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _headers = [NSArray arrayWithSipHeaderVector:&config.headers];
    _publishEnabled = config.publishEnabled;
    _publishQueue = config.publishQueue;
    _publishShutdownWaitMsec = config.publishShutdownWaitMsec;
    _pidfTupleId = [NSString stringWithCPPString:&config.pidfTupleId];
    
    return self;
}

+(instancetype)presenceConfigurationFromAccountPresConfig:(pj::AccountPresConfig)config {
    
    return [[SWAccountPresenceConfiguration alloc] initWithAccountPresConfig:config];
}

-(pj::AccountPresConfig)config {
    
    pj::AccountPresConfig config;
    config.headers = *[self.headers sipHeaderVector];
    config.publishEnabled = self.publishEnabled;
    config.publishQueue = self.publishQueue;
    config.publishShutdownWaitMsec = self.publishShutdownWaitMsec;
    config.pidfTupleId = *[self.pidfTupleId CPPString];
    
    return config;
}

@end
