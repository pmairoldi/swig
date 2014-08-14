//
//  SWUserAgent.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWUserAgent.h"
#import "SWEndpoint.h"
#import "PJSUA2.h"

@implementation SWUserAgent

-(instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    SWTransportConfiguration *config1 = [SWTransportConfiguration new];
    config1.transportType = PJSIP_TRANSPORT_UDP;
    
    SWTransportConfiguration *config2 = [SWTransportConfiguration new];
    config2.transportType = PJSIP_TRANSPORT_TCP;
    
    SWEndpoint *endpoint = [[SWEndpoint alloc] init];
    endpoint.transportConfigurations = @[config1, config2];
    
    [endpoint begin];
    
    return self;
}

-(void)dealloc {
    
}

@end
