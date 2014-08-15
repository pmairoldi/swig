//
//  SWAccountConfiguration.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWAccountConfiguration.h"
#import "NSString+String.h"

@implementation SWAccountConfiguration

-(instancetype)init {
    
    return [self initWithURI:nil];
}

-(instancetype)initWithURI:(NSString *)uri {
    
    if (!uri || [uri isEqualToString:@""]) {
        NSAssert(@"no sip address specified", @"you must specify a sip address for the account");
        return nil;
    }
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    pj::AccountConfig config;
    
    self.priority = config.priority;
    self.idUri = uri;
    self.regConfig = [SWAccountRegistrationConfiguration new];
    self.sipConfig = [SWAccountSipConfiguration new];
    self.callConfig = [SWAccountCallConfiguration new];
    self.presConfig = [SWAccountPresenceConfiguration new];
    self.mwiConfig = [SWAccountMWIConfiguration new];
    self.natConfig = [SWAccountNATConfiguration new];
    self.mediaConfig = [SWAccountMediaConfiguration new];
    self.videoConfig = [SWAccountVideoConfiguration new];
    
    return self;
}


-(pj::AccountConfig)config {
    
    pj::AccountConfig config;
    
    config.priority = self.priority;
    config.idUri = *[self.idUri CPPString];
    config.regConfig = self.regConfig.config;
    config.sipConfig = self.sipConfig.config;
    config.callConfig = self.callConfig.config;
    config.presConfig = self.presConfig.config;
    config.mwiConfig = self.mwiConfig.config;
    config.natConfig = self.natConfig.config;
    config.mediaConfig = self.mediaConfig.config;
    config.videoConfig = self.videoConfig.config;
    
    return config;
}

@end
