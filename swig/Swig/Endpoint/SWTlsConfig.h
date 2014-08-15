//
//  SWTlsConfig.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pjsip/sip_transport_tls.h"
#import "pjsip/sip_types.h"

#ifdef __cplusplus
#include "pjsua2/siptypes.hpp"
#endif

@interface SWTlsConfig : NSObject

@property (nonatomic, strong) NSString *CaListFile;
@property (nonatomic, strong) NSString *certFile;
@property (nonatomic, strong) NSString *privKeyFile;
@property (nonatomic, strong) NSString *password;
@property (nonatomic) pjsip_ssl_method method;
@property (nonatomic, strong) NSArray *ciphers;
@property (nonatomic) BOOL verifyServer;
@property (nonatomic) BOOL verifyClient;
@property (nonatomic) BOOL requireClientCert;
@property (nonatomic) NSUInteger msecTimeout;
@property (nonatomic) pj_qos_type qosType;
@property (nonatomic) pj_qos_params qosParams;

#ifdef __cplusplus
-(pj::TlsConfig)config;
#endif

@end
