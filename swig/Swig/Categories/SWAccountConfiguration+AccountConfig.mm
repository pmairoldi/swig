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

@implementation SWAccountConfiguration (AccountConfig)

-(pj::AccountConfig *)toAccountConfig {
    
    pj::AccountConfig *config = new pj::AccountConfig;
    
    NSString *address = self.address;
    
    if ([address rangeOfString:@"@"].location == NSNotFound) {
        address = [NSString stringWithFormat:@"%@@%@", address, self.domain];
    }
    
    config->idUri = *[[SWUriFormatter sipUri:address] CPPString]; //use uri formatter
    
    config->regConfig.registrarUri = *[[SWUriFormatter sipUri:self.domain] CPPString];
    config->regConfig.registerOnAdd = self.registerOnAdd;
    
    pj::AuthCredInfo authInfo;
    authInfo.scheme = *[self.authScheme CPPString];
    authInfo.realm = *[self.authRealm CPPString];
    authInfo.username = *[self.username CPPString];
    authInfo.data = *[self.password CPPString];
    
    config->sipConfig.authCreds.push_back(authInfo);
    
    if (self.proxy) {
        config->sipConfig.proxies.push_back(*[[SWUriFormatter sipUri:self.proxy] CPPString]);
    }
    
    return config;
}

@end
