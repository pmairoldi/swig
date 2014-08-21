//
//  SWEndpointConfiguration+EpConfig.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-21.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWEndpointConfiguration+EpConfig.h"
#import "NSString+String.h"

@implementation SWEndpointConfiguration (EpConfig)

//+(SWEndpointConfiguration *)configurationWithEpConfig:(pj::EpConfig)config {
//    
//    SWEndpointConfiguration *configuration = [SWEndpointConfiguration new];
//    configuration.maxCalls = config.uaConfig.maxCalls;
//    configuration.logLevel = config.logConfig.level;
//    configuration.logConsoleLevel = config.logConfig.consoleLevel;
//    configuration.logFilename = [NSString stringWithCPPString:&config.logConfig.filename];
//    configuration.logFileFlags = config.logConfig.fileFlags;
//    configuration.clockRate = config.medConfig.clockRate;
//    configuration.sndClockRate = config.medConfig.sndClockRate;
//    
//    //TODO transport config
//
//    return configuration;
//}

-(pj::EpConfig *)toEpConfig {
    
    pj::EpConfig *config = new pj::EpConfig;
    config->uaConfig.maxCalls = self.maxCalls;
    config->logConfig.level = self.logLevel;
    config->logConfig.consoleLevel = self.logConsoleLevel;
    
    if (self.logFilename) {
        config->logConfig.filename = *[self.logFilename CPPString];
    }
    
    config->logConfig.fileFlags = self.logFileFlags;
    config->medConfig.clockRate = self.clockRate;
    config->medConfig.sndClockRate = self.sndClockRate;
    
    return config;
}

@end
