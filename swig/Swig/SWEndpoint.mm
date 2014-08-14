//
//  SWEndpoint.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWEndpoint.h"
#import "PJSUA2.h"

@interface SWEndpoint ()

@property Endpoint *endpoint;

@end

@implementation SWEndpoint

-(instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _userAgentConfiguration = [SWUserAgentConfiguration new];
    _logConfiguration = [SWLogConfiguration new];
    _mediaConfiguration = [SWMediaConfiguration new];
    _transportConfigurations = @[];
    
    return self;
}

-(void)begin {
    
    [self createWithSuccess:^{
        
        [self initWithSuccess:^{
            
            [self createTransportWithSuccess:^{
                
                [self startWithSuccess:nil failure:nil];
                
            } failure:nil];
            
        } failure:nil];
        
    } failure:nil];
}

-(void)createWithSuccess:(void (^)())success failure:(void (^)(NSError *error))failure {
    
    if (!self.endpoint) {
        self.endpoint = new Endpoint;
    }
    
    NSError *error;
    
    try {
        self.endpoint->libCreate();
    } catch(Error& err) {
        error = [NSError errorFromError:[NSValue valueWithPointer:&err]];
    }
    
    if (error) {
        if (failure) {
            failure(error);
        }
    }
    
    else {
        if (success) {
            success();
        }
    }
}

-(void)initWithSuccess:(void (^)())success failure:(void (^)(NSError *error))failure {
    
    NSError *error;
    
    try {
        self.endpoint->libInit([self epConfig]);
    } catch(Error& err) {
        error = [NSError errorFromError:[NSValue valueWithPointer:&err]];
    }
    
    if (error) {
        if (failure) {
            failure(error);
        }
    }
    
    else {
        if (success) {
            success();
        }
    }
}

-(void)createTransportWithSuccess:(void (^)())success failure:(void (^)(NSError *error))failure {
    
    NSError *error;
    
    try {
       
        for (SWTransportConfiguration *transport in self.transportConfigurations) {
            self.endpoint->transportCreate(transport.transportType, [self tranportConfig:transport]);
        }
        
    } catch(Error& err) {
        error = [NSError errorFromError:[NSValue valueWithPointer:&err]];
    }
    
    if (error) {
        if (failure) {
            failure(error);
        }
    }
    
    else {
        if (success) {
            success();
        }
    }
}

-(void)startWithSuccess:(void (^)())success failure:(void (^)(NSError *error))failure {
    
    NSError *error;
    
    try {
        self.endpoint->libStart();
    } catch(Error& err) {
        error = [NSError errorFromError:[NSValue valueWithPointer:&err]];
    }
    
    if (error) {
        if (failure) {
            failure(error);
        }
    }
    
    else {
        if (success) {
            success();
        }
    }
}

-(void)destroyWithSuccess:(void (^)())success failure:(void (^)(NSError *error))failure {
    
    NSError *error;
    
    try {
        self.endpoint->libDestroy();
        delete self.endpoint;
    } catch(Error& err) {
        error = [NSError errorFromError:[NSValue valueWithPointer:&err]];
    }
    
    if (error) {
        if (failure) {
            failure(error);
        }
    }
    
    else {
        if (success) {
            success();
        }
    }
}

-(EpConfig)epConfig {
    
    EpConfig config;
    
    config.uaConfig.maxCalls = self.userAgentConfiguration.maxCalls;
    config.uaConfig.threadCnt = self.userAgentConfiguration.threadCnt;
    config.uaConfig.mainThreadOnly = self.userAgentConfiguration.mainThreadOnly;
    config.uaConfig.nameserver = *(StringVector *)[[self.userAgentConfiguration.nameserver stringVector] pointerValue];
    config.uaConfig.userAgent = *(string *)[[self.userAgentConfiguration.userAgent CPPString] pointerValue];
    config.uaConfig.stunServer = *(StringVector *)[[self.userAgentConfiguration.stunServer stringVector] pointerValue];;
    config.uaConfig.stunIgnoreFailure = self.userAgentConfiguration.stunIgnoreFailure;
    config.uaConfig.natTypeInSdp = self.userAgentConfiguration.natTypeInSdp;
    config.uaConfig.mwiUnsolicitedEnabled = self.userAgentConfiguration.mwiUnsolicitedEnabled;
    
    config.logConfig.msgLogging = self.logConfiguration.msgLogging;
    config.logConfig.level = self.logConfiguration.level;
    config.logConfig.consoleLevel = self.logConfiguration.consoleLevel;
    config.logConfig.decor = self.logConfiguration.decor;
    config.logConfig.filename = *(string *)[[self.logConfiguration.filename CPPString] pointerValue];
    config.logConfig.fileFlags = self.logConfiguration.fileFlags;
    
    config.medConfig.clockRate = self.mediaConfiguration.clockRate;
    config.medConfig.sndClockRate = self.mediaConfiguration.sndClockRate;
    config.medConfig.channelCount = self.mediaConfiguration.channelCount;
    config.medConfig.audioFramePtime = self.mediaConfiguration.audioFramePtime;
    config.medConfig.maxMediaPorts = self.mediaConfiguration.maxMediaPorts;
    config.medConfig.hasIoqueue = self.mediaConfiguration.hasIoqueue;
    config.medConfig.threadCnt = self.mediaConfiguration.threadCnt;
    config.medConfig.quality = self.mediaConfiguration.quality;
    config.medConfig.ptime = self.mediaConfiguration.ptime;
    config.medConfig.noVad = self.mediaConfiguration.noVad;
    config.medConfig.ilbcMode = self.mediaConfiguration.ilbcMode;
    config.medConfig.txDropPct = self.mediaConfiguration.txDropPct;
    config.medConfig.rxDropPct = self.mediaConfiguration.rxDropPct;
    config.medConfig.ecOptions = self.mediaConfiguration.ecOptions;
    config.medConfig.ecTailLen = self.mediaConfiguration.ecTailLen;
    config.medConfig.sndRecLatency = self.mediaConfiguration.sndRecLatency;
    config.medConfig.sndPlayLatency = self.mediaConfiguration.sndPlayLatency;
    config.medConfig.jbInit = self.mediaConfiguration.jbInit;
    config.medConfig.jbMinPre = self.mediaConfiguration.jbMinPre;
    config.medConfig.jbMaxPre = self.mediaConfiguration.jbMaxPre;
    config.medConfig.jbMax = self.mediaConfiguration.jbMax;
    config.medConfig.sndAutoCloseTime = self.mediaConfiguration.sndAutoCloseTime;
    config.medConfig.vidPreviewEnableNative = self.mediaConfiguration.vidPreviewEnableNative;
    
    return config;
}

-(TransportConfig)tranportConfig:(SWTransportConfiguration *)config {
    
    TransportConfig transportConfig;
    transportConfig.port = config.port;
    transportConfig.portRange = config.portRange;
    transportConfig.publicAddress = *(string *)[[config.publicAddress CPPString] pointerValue];
    transportConfig.boundAddress = *(string *)[[config.boundAddress CPPString] pointerValue];

    return transportConfig;
}

@end
