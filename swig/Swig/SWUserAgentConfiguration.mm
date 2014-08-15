//
//  SWm
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWUserAgentConfiguration.h"
#import "NSArray+StringVector.h"
#import "NSString+String.h"

@interface SWUserAgentConfiguration ()

@property (nonatomic) pj::UaConfig *config;

@end

@implementation SWUserAgentConfiguration

-(instancetype)init {

    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _config = new pj::UaConfig;
    
    return self;
}

-(void)dealloc {
    
    delete _config;
}

-(pj::UaConfig *)config {
    
    return _config;
}

-(void)setMaxCalls:(NSUInteger)maxCalls {
    
    _config->maxCalls = maxCalls;
}

-(NSUInteger)maxCalls {
    
    return _config->maxCalls;
}

-(void)setThreadCnt:(NSUInteger)threadCnt {
    
    _config->threadCnt = threadCnt;
}

-(NSUInteger)threadCnt {
    
    return _config->threadCnt;
}

-(void)setMainThreadOnly:(BOOL)mainThreadOnly {
    
    _config->mainThreadOnly = mainThreadOnly;
}

-(BOOL)mainThreadOnly {
    
    return _config->mainThreadOnly;
}

-(void)setNameserver:(NSArray *)nameserver {
    
    _config->nameserver = *[nameserver stringVector];
}

-(NSArray *)nameserver {
    
    return [NSArray arrayWithStringVector:&_config->nameserver];
}

-(void)setUserAgent:(NSString *)userAgent {
    
    _config->userAgent = *[userAgent CPPString];
}

-(NSString *)userAgent {
    
    return [NSString stringFromCPPString:&_config->userAgent];
}

-(void)setStunServer:(NSArray *)stunServer {
    
    _config->stunServer = *[stunServer stringVector];
}

-(NSArray *)stunServer {
    
    return [NSArray arrayWithStringVector:&_config->stunServer];
}

-(void)setStunIgnoreFailure:(BOOL)stunIgnoreFailure {
    
    _config->stunIgnoreFailure = stunIgnoreFailure;
}

-(BOOL)stunIgnoreFailure {
    
    return _config->stunIgnoreFailure;
}

-(void)setNatTypeInSdp:(NSInteger)natTypeInSdp {
    
    _config->natTypeInSdp = natTypeInSdp;
}

-(NSInteger)natTypeInSdp {
    
    return _config->natTypeInSdp;
}

-(void)setMwiUnsolicitedEnabled:(BOOL)mwiUnsolicitedEnabled {
    
    _config->mwiUnsolicitedEnabled = mwiUnsolicitedEnabled;
}

-(BOOL)mwiUnsolicitedEnabled {
    
    return _config->mwiUnsolicitedEnabled;
}

@end