//
//  SWAccountRegistrationConfiguration.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWAccountRegistrationConfiguration.h"
#import "NSString+String.h"
#import "NSArray+SipHeaderVector.h"

@implementation SWAccountRegistrationConfiguration

-(instancetype)init {
    
    pj::AccountRegConfig config;

    return [self initWithAccountRegConfig:config];
}

-(instancetype)initWithAccountRegConfig:(pj::AccountRegConfig)config_ {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    pj::AccountRegConfig config = config_;
    
    _registrarUri = [NSString stringWithCPPString:&config.registrarUri];
    _registerOnAdd = config.registerOnAdd;
    _headers = [NSArray arrayWithSipHeaderVector:&config.headers];
    _timeoutSec = config.timeoutSec;
    _retryIntervalSec = config.retryIntervalSec;
    _firstRetryIntervalSec = config.firstRetryIntervalSec;
    _delayBeforeRefreshSec = config.delayBeforeRefreshSec;
    _dropCallsOnFail = config.dropCallsOnFail;
    _unregWaitSec = config.unregWaitSec;
    _proxyUse = config.proxyUse;
    
    return self;
}

+(instancetype)registrationConfigurationFromAccountRegConfig:(pj::AccountRegConfig)config {
    
    return [[SWAccountRegistrationConfiguration alloc] initWithAccountRegConfig:config];
}

-(pj::AccountRegConfig)config {
    
    pj::AccountRegConfig config;
    config.registrarUri = *[self.registrarUri CPPString];
    config.registerOnAdd = self.registerOnAdd;
    config.headers = *[self.headers sipHeaderVector];
    config.timeoutSec = (unsigned int)self.timeoutSec;
    config.retryIntervalSec = (unsigned int)self.retryIntervalSec;
    config.firstRetryIntervalSec = (unsigned int)self.firstRetryIntervalSec;
    config.delayBeforeRefreshSec = (unsigned int)self.delayBeforeRefreshSec;
    config.dropCallsOnFail = self.dropCallsOnFail;
    config.unregWaitSec = (unsigned int)self.unregWaitSec;
    config.proxyUse = (unsigned int)self.proxyUse;
    
    return config;
}

@end
