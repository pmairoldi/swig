//
//  SWEndpointConfiguration.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-20.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWEndpointConfiguration.h"
#import "SWTransportConfiguration.h"
#include "pj/file_io.h"

#define kSWMaxCalls 4
#define kSWLogLevel 5
#define kSWLogConsoleLevel 4
#define kSWLogFilename nil
#define kSWLogFileFlags PJ_O_APPEND
#define kSWClockRate 16000
#define kSWSndClockRate 0

@implementation SWEndpointConfiguration

-(instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    //ua config
    _maxCalls = kSWMaxCalls;
    
    //log config
    _logLevel = kSWLogLevel;
    _logConsoleLevel = kSWLogConsoleLevel;
    _logFilename = kSWLogFilename;
    _logFileFlags = kSWLogFileFlags;
    
    //media config
    _clockRate = kSWClockRate;
    _sndClockRate = kSWSndClockRate;
    
    _transportConfigurations = [NSArray new];
    
    return self;
}

+(instancetype)configurationWithTransportConfigurations:(NSArray *)transportConfigurations {
    
    if (!transportConfigurations || transportConfigurations.count == 0) {
    
        // DDLogDebug(@"A transport configuration needs to be specified. Created a basic UDP configuration for you.");
        SWTransportConfiguration *configuration = [SWTransportConfiguration configurationWithTransportType:SWTransportTypeUDP];
        
        transportConfigurations = @[configuration];
    }
    
    SWEndpointConfiguration *endpointConfiguration = [SWEndpointConfiguration new];
    endpointConfiguration.transportConfigurations = transportConfigurations;
    
    return endpointConfiguration;
}

@end
