//
//  SWTransportConfiguration.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWTransportConfiguration.h"
#import "NSString+String.h"

#define kDefaultPort 5060

@interface SWTransportConfiguration ()

@end

@implementation SWTransportConfiguration

-(instancetype)init {
    
    return [self initWithPort:kDefaultPort transportType:PJSIP_TRANSPORT_UDP];
}

-(instancetype)initWithTransportType:(pjsip_transport_type_e)transportType {
    
    return [self initWithPort:kDefaultPort transportType:transportType];
}

-(instancetype)initWithPort:(NSUInteger)port transportType:(pjsip_transport_type_e)transportType {

    self = [super init];
    
    if (!self) {
        return nil;
    }

    pj::TransportConfig config;
    
    self.port = port;
    self.portRange = config.portRange;
    self.publicAddress = [NSString stringWithCPPString:&config.publicAddress];
    self.boundAddress = [NSString stringWithCPPString:&config.boundAddress];
    self.tlsConfig = [SWTlsConfiguration new];
    self.qosType = config.qosType;
    self.qosParams = config.qosParams;
    
    self.transportType = transportType;
    
    return self;
}

-(pj::TransportConfig)config {
    
    pj::TransportConfig config;

    config.port = (unsigned int)self.port;
    config.portRange = (unsigned int)self.portRange;
    config.publicAddress = *[self.publicAddress CPPString];
    config.boundAddress = *[self.boundAddress CPPString];
    config.tlsConfig = self.tlsConfig.config;
    config.qosType = config.qosType;
    config.qosParams = config.qosParams;
    
    return config;
}

@end