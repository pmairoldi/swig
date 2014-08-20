//
//  SWEndpoint.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWEndpoint.h"
#import "NSError+Error.h"

#include "pjsua2/endpoint.hpp"

@interface SWEndpoint ()

@property pj::Endpoint *endpoint;

@end

@implementation SWEndpoint

-(instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _endPointConfiguration = [SWEndpointConfiguration new];
    
    _transportConfigurations = @[];
    
    return self;
}

-(void)dealloc {
    
    [self destroyWithSuccess:nil failure:nil];
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
        error = [NSError errorWithError:&err];
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
        
        self.endpoint->libInit(self.endPointConfiguration.config);
    } catch(pj::Error& err) {
        error = [NSError errorWithError:&err];
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
            self.endpoint->transportCreate(transport.transportType, transport.config);
        }
        
    } catch(pj::Error& err) {
        error = [NSError errorWithError:&err];
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
        error = [NSError errorWithError:&err];
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
        error = [NSError errorWithError:&err];
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
