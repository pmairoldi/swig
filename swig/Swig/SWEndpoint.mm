//
//  SWEndpoint.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWEndpoint.h"
#import "NSError+Error.h"

#ifdef __cplusplus
#include "pjsua2/endpoint.hpp"
#endif

@interface SWEndpoint ()

@property pj::Endpoint *endpoint;

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

-(void)dealloc {
    
    delete _endpoint;
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
    
    NSError *error;
    
    if (!self.endpoint) {
        self.endpoint = new pj::Endpoint;
    }
    
    try {
        self.endpoint->libCreate();
    } catch(pj::Error& err) {
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
        
        pj::EpConfig config;
        config.uaConfig = *self.userAgentConfiguration.config;
        config.logConfig = *self.logConfiguration.config;
        config.medConfig = *self.mediaConfiguration.config;
        
        self.endpoint->libInit(config);
    } catch(pj::Error& err) {
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
            self.endpoint->transportCreate(transport.transportType, *transport.config);
        }
        
    } catch(pj::Error& err) {
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
    } catch(pj::Error& err) {
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
    } catch(pj::Error& err) {
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

@end
