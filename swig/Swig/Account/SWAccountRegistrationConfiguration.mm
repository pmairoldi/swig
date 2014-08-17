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
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    pj::AccountRegConfig config;
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

-(pj::AccountRegConfig)config {
    
    pj::AccountRegConfig config;
    config.registrarUri = *[self.registrarUri CPPString];
    config.registerOnAdd = self.registerOnAdd;
    config.headers = *[self.headers sipHeaderVector];
    config.timeoutSec = self.timeoutSec;
    config.retryIntervalSec = self.retryIntervalSec;
    config.firstRetryIntervalSec = self.firstRetryIntervalSec;
    config.delayBeforeRefreshSec = self.delayBeforeRefreshSec;
    config.dropCallsOnFail = self.dropCallsOnFail;
    config.unregWaitSec = self.unregWaitSec;
    config.proxyUse = self.proxyUse;
    
    return config;
}

@end
