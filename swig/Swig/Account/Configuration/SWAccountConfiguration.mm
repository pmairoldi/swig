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
    
    pj::AccountConfig config;
    config.idUri = *[uri CPPString];
    
    return [self initWithAccountConfig:config];
}

-(instancetype)initWithAccountConfig:(pj::AccountConfig)config_ {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    pj::AccountConfig config = config_;

    _priority = config.priority;
    _idUri = [NSString stringWithCPPString:&config.idUri];
    _regConfig = [SWAccountRegistrationConfiguration registrationConfigurationFromAccountRegConfig:config.regConfig];
    _sipConfig = [SWAccountSipConfiguration sipConfigurationFromAccountSipConfig:config.sipConfig];
    _callConfig = [SWAccountCallConfiguration callConfigurationFromAccountCallConfig:config.callConfig];
    _presConfig = [SWAccountPresenceConfiguration presenceConfigurationFromAccountPresConfig:config.presConfig];
    _mwiConfig = [SWAccountMWIConfiguration mwiConfigurationFromAccountMwiConfig:config.mwiConfig];
    _natConfig = [SWAccountNATConfiguration natConfigurationFromAccountNatConfig:config.natConfig];
    _mediaConfig = [SWAccountMediaConfiguration mediaConfigurationFromAccountMediaConfig:config.mediaConfig];
    _videoConfig = [SWAccountVideoConfiguration videoConfigurationFromAccountVideoConfig:config.videoConfig];
    
    return self;
}

+(instancetype)accountConfigurationFromAccountId:(NSInteger)accountId {
    
    pjsua_acc_config acc_cfg;
    //TODO find way to get media config;
    //pjsua_media_config med_cfg;
    
    pjsua_acc_get_config(accountId, NULL, &acc_cfg);
    
    pj::AccountConfig config;
    config.fromPj(acc_cfg, NULL);
    
    return [[SWAccountConfiguration alloc] initWithAccountConfig:config];
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
