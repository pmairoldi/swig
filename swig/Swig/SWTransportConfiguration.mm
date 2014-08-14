//
//  SWTransportConfiguration.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWTransportConfiguration.h"
#import "PJSUA2.h"

#define kDefaultPort 5060

@implementation SWTransportConfiguration

-(instancetype)init {
    
    return [self initWithPort:kDefaultPort];
}

-(instancetype)initWithPort:(NSUInteger)port {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }

    TransportConfig tranportConfig;
    tranportConfig.port = port;
    
    _port = tranportConfig.port;
    _portRange = tranportConfig.portRange;
    _publicAddress = [NSString stringFromCPPString:[NSValue valueWithPointer:&tranportConfig.publicAddress]];
    _boundAddress = [NSString stringFromCPPString:[NSValue valueWithPointer:&tranportConfig.boundAddress]];
    
    _transportType = PJSIP_TRANSPORT_UDP;
    
    return self;
}

@end
