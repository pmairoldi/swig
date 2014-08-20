//
//  SWAccountSipConfiguration.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWAccountSipConfiguration.h"
#import "NSArray+StringVector.h"
#import "NSString+String.h"
#import "NSArray+AuthCredInfoVector.h"

@implementation SWAccountSipConfiguration

-(instancetype)init {
    
    pj::AccountSipConfig config;
    
    return [self initWithAccountSipConfig:config];
}

-(instancetype)initWithAccountSipConfig:(pj::AccountSipConfig)config_ {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    pj::AccountSipConfig config = config_;
    
    _authCreds = [NSArray arrayWithAuthCredInfoVector:&config.authCreds];
    _proxies = [NSArray arrayWithStringVector:&config.proxies];
    _contactForced = [NSString stringWithCPPString:&config.contactForced];
    _contactParams = [NSString stringWithCPPString:&config.contactParams];
    _contactUriParams = [NSString stringWithCPPString:&config.contactUriParams];
    _authInitialEmpty = config.authInitialEmpty;
    _authInitialAlgorithm = [NSString stringWithCPPString:&config.authInitialAlgorithm];
    _transportId = config.transportId;
    
    return self;
}

+(instancetype)sipConfigurationFromAccountSipConfig:(pj::AccountSipConfig)config {

    return [[SWAccountSipConfiguration alloc] initWithAccountSipConfig:config];
}

-(pj::AccountSipConfig)config {
    
    pj::AccountSipConfig config;
    config.authCreds = *[self.authCreds authCredInfoVector];
    config.proxies = *[self.proxies stringVector];
    config.contactForced = *[self.contactForced CPPString];
    config.contactParams = *[self.contactParams CPPString];
    config.contactUriParams = *[self.contactUriParams CPPString];
    config.authInitialEmpty = self.authInitialEmpty;
    config.authInitialAlgorithm = *[self.authInitialAlgorithm CPPString];
    config.transportId = (int)self.transportId;
    
    return config;
}

@end
