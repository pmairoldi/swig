//
//  SWUserAgentConfiguration.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWUserAgentConfiguration.h"
#import "PJSUA2.h"

@implementation SWUserAgentConfiguration

-(instancetype)init {

    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    UaConfig config;
    
    _maxCalls = config.maxCalls;
    _threadCnt = config.threadCnt;
    _mainThreadOnly = config.mainThreadOnly;
    _nameserver = [NSArray arrayWithStringVector:[NSValue valueWithPointer:&config.nameserver]];
    _userAgent = [NSString stringFromCPPString:[NSValue valueWithPointer:&config.userAgent]];
    _stunServer = [NSArray arrayWithStringVector:[NSValue valueWithPointer:&config.stunServer]];
    _stunIgnoreFailure = config.stunIgnoreFailure;
    _natTypeInSdp = config.natTypeInSdp;
    _mwiUnsolicitedEnabled = config.mwiUnsolicitedEnabled;
    
    return self;
}

@end
