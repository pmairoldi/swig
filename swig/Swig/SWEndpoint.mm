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
    _userAgentConfiguration.maxCalls = 10;
    
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
        error = [NSError errorFromError:&err];
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
        error = [NSError errorFromError:&err];
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
        error = [NSError errorFromError:&err];
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
        error = [NSError errorFromError:&err];
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
        error = [NSError errorFromError:&err];
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
    
    config.uaConfig = *self.userAgentConfiguration.config;
    config.logConfig = *self.logConfiguration.config;
    config.medConfig = *self.mediaConfiguration.config;
           
    return config;
}

-(TransportConfig)tranportConfig:(SWTransportConfiguration *)config {
    
    TransportConfig transportConfig;
    transportConfig.port = config.port;
    transportConfig.portRange = config.portRange;
    transportConfig.publicAddress = *[config.publicAddress CPPString];
    transportConfig.boundAddress = *[config.boundAddress CPPString];

    return transportConfig;
}

@end
