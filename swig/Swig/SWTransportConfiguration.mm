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

@property (nonatomic) pj::TransportConfig *config;

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

    _config = new pj::TransportConfig;
    
    self.port = port;
    self.transportType = transportType;
    
    return self;
}

-(pj::TransportConfig *)config {
    
    return _config;
}

-(void)setPort:(NSUInteger)port{
    
    _config->port = port;
}

-(NSUInteger)port{
 
    return _config->port;
}

-(void)setPortRange:(NSUInteger)portRange{
    
    _config->portRange = portRange;
}

-(NSUInteger)portRange{
    
    return _config->portRange;
}

-(void)setPublicAddress:(NSString *)publicAddress{
    
    _config->publicAddress = *[publicAddress CPPString];
}

-(NSString *)publicAddress{
 
    return [NSString stringFromCPPString:&_config->publicAddress];
}

-(void)setBoundAddress:(NSString *)boundAddress{
 
    _config->boundAddress = *[boundAddress CPPString];
}

-(NSString *)boundAddress{
    
    return [NSString stringFromCPPString:&_config->boundAddress];
}

-(void)setTlsConfig:(SWTlsConfig *)tlsConfig{
    
    _config->tlsConfig = *tlsConfig.config;
}

-(SWTlsConfig *)tlsConfig{
    
    return [[SWTlsConfig alloc] initWithConfig:&_config->tlsConfig];
}

-(void)setQosType:(pj_qos_type)qosType{
    
    _config->qosType = qosType;
}

-(pj_qos_type)qosType{
    
    return _config->qosType;
}

-(void)setQosParams:(pj_qos_type)qosParams{
    
    _config->qosParams = qosParams;
}

-(pj_qos_type)qosParams{
    
    return _config->qosParams;
}

@end