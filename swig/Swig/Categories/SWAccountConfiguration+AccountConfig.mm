//
//  SWAccountConfiguration+AccountConfig.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-21.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWAccountConfiguration+AccountConfig.h"
#import "NSString+String.h"
#import "SWUriFormatter.h"
#import "SWEndpoint.h"

@implementation SWAccountConfiguration (AccountConfig)

-(pj::AccountConfig *)toAccountConfig {
    
    pj::AccountConfig *config = new pj::AccountConfig;
    
    NSString *tcpSuffix = @"";
    
    if ([[SWEndpoint sharedInstance] hasTCPConfiguration]) {
        tcpSuffix = @";transport=TCP";
    }
    
    //TODO test tcp stuff is working
    
    config->idUri = *[[SWUriFormatter sipUri:self.address] CPPString];
    config->regConfig.registrarUri = *[[SWUriFormatter sipUri:[self.domain stringByAppendingString:tcpSuffix]] CPPString];
    config->regConfig.registerOnAdd = self.registerOnAdd;
//    config->regConfig.timeoutSec = 600;
    
    pj::AuthCredInfo authInfo;
    authInfo.scheme = *[self.authScheme CPPString];
    authInfo.realm = *[self.authRealm CPPString];
    authInfo.username = *[self.username CPPString];
    authInfo.data = *[self.password CPPString];
    
    config->sipConfig.authCreds.push_back(authInfo);
    
    if (self.proxy) {
        config->sipConfig.proxies.push_back(*[[SWUriFormatter sipUri:[self.proxy stringByAppendingString:tcpSuffix]] CPPString]);
    }
    
    config->presConfig.publishEnabled = self.publishEnabled;
    
    return config;
}

@end
