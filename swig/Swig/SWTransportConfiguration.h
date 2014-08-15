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

@property (nonatomic) NSUInteger port;
@property (nonatomic) NSUInteger portRange;
@property (nonatomic, strong) NSString *publicAddress;
@property (nonatomic, strong) NSString *boundAddress;
@property (nonatomic, strong) SWTlsConfig *tlsConfig;
@property (nonatomic) pj_qos_type qosType;
@property (nonatomic) pj_qos_type qosParams;
@property (nonatomic) pjsip_transport_type_e transportType;

-(instancetype)initWithTransportType:(pjsip_transport_type_e)transportType;
-(instancetype)initWithPort:(NSUInteger)port transportType:(pjsip_transport_type_e)transportType;

#ifdef __cplusplus
-(pj::TransportConfig)config;
#endif

@end
