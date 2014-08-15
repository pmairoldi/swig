//
//  SWTransportConfiguration.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pjsip/sip_types.h"

#ifdef __cplusplus
#include "pjsua2/endpoint.hpp"
#endif
#import "SWTlsConfig.h"

@interface SWTransportConfiguration : NSObject

@property pjsip_transport_type_e transportType;

-(instancetype)initWithTransportType:(pjsip_transport_type_e)transportType;
-(instancetype)initWithPort:(NSUInteger)port transportType:(pjsip_transport_type_e)transportType;

//getters
#ifdef __cplusplus
-(pj::TransportConfig *)config;
#endif
-(NSUInteger)port;
-(NSUInteger)portRange;
-(NSString *)publicAddress;
-(NSString *)boundAddress;
-(SWTlsConfig *)tlsConfig;
-(pj_qos_type)qosType;
-(pj_qos_type)qosParams;

//setters
-(void)setPort:(NSUInteger)port;
-(void)setPortRange:(NSUInteger)portRange;
-(void)setPublicAddress:(NSString *)publicAddress;
-(void)setBoundAddress:(NSString *)boundAddress;
-(void)setTlsConfig:(SWTlsConfig *)tlsConfig;
-(void)setQosType:(pj_qos_type)qosType;
-(void)setQosParams:(pj_qos_type)qosParams;

@end
