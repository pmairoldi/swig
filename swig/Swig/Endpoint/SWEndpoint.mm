//
//  SWEndpoint.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-20.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWEndpoint.h"
#import "pjsua2.hpp"
#import "NSError+Error.h"

@interface SWEndpoint ()

@end

@implementation SWEndpoint

static SWEndpoint *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+(id)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}

#pragma mark - Life Cycle

+(id) allocWithZone:(NSZone *)zone {
    return [self sharedInstance];
}

+(id)copyWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

+(id)mutableCopyWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

-(id)copy {
    return [[SWEndpoint alloc] init];
}

-(id)mutableCopy {
    return [[SWEndpoint alloc] init];
}

-(id)init {
    
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    
    self = [super init];
    
    pj::Endpoint endpoint = pj::Endpoint::instance();

    try {
        
        endpoint.libCreate();
    
        pj::EpConfig ep_cfg;
        endpoint.libInit(ep_cfg);
        
    } catch(pj::Error &err) {
        NSError *error = [NSError errorWithError:&err];
        NSAssert(error, [error description]);
    }
    
    return self;
}

-(void)startWithTransportConfigurations:(NSArray *)transportConfigurations {
    
}

@end
