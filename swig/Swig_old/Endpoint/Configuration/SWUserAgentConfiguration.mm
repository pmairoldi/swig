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

@end

@implementation SWUserAgentConfiguration

-(instancetype)init {

    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    pj::UaConfig config;
    
    self.maxCalls = config.maxCalls;
    self.threadCnt = config.threadCnt;
    self.mainThreadOnly = config.mainThreadOnly;
    self.nameserver = [NSArray arrayWithStringVector:&config.nameserver];
    self.userAgent = [NSString stringWithCPPString:&config.userAgent];
    self.stunServer = [NSArray arrayWithStringVector:&config.stunServer];
    self.stunIgnoreFailure = config.stunIgnoreFailure;
    self.natTypeInSdp = config.natTypeInSdp;
    self.mwiUnsolicitedEnabled = config.mwiUnsolicitedEnabled;

    return self;
}

-(pj::UaConfig)config {
    
    pj::UaConfig config;
    
    config.maxCalls = (unsigned int)self.maxCalls;
    config.threadCnt = (unsigned int)self.threadCnt;
    config.mainThreadOnly = self.mainThreadOnly;
    config.nameserver = *[self.nameserver stringVector];
    config.userAgent = *[self.userAgent CPPString];
    config.stunServer =  *[self.stunServer stringVector];
    config.stunIgnoreFailure = self.stunIgnoreFailure;
    config.natTypeInSdp = (int)self.natTypeInSdp;
    config.mwiUnsolicitedEnabled = self.mwiUnsolicitedEnabled;
    
    return config;
}

@end