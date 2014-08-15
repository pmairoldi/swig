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

#ifdef __cplusplus
-(instancetype)initWithConfig:(pj::TlsConfig *)config;
#endif

//getters
#ifdef __cplusplus
-(pj::TlsConfig *)config;
#endif
-(NSString *)CaListFile;
-(NSString *)certFile;
-(NSString *)privKeyFile;
-(NSString *)password;
-(pjsip_ssl_method)method;
-(NSArray *)ciphers;
-(BOOL)verifyServer;
-(BOOL)verifyClient;
-(BOOL)requireClientCert;
-(NSUInteger)msecTimeout;
-(pj_qos_type)qosType;
-(pj_qos_params)qosParams;

//setters
-(void)setCaListFile:(NSString *)CaListFile;
-(void)setCertFile:(NSString *)certFile;
-(void)setPrivKeyFile:(NSString *)privKeyFile;
-(void)setPasswordFile:(NSString *)password;
-(void)setMethod:(pjsip_ssl_method)method;
-(void)setCiphers:(NSArray *)ciphers;
-(void)setVerifyServer:(BOOL)verifyServer;
-(void)setVerifyClient:(BOOL)verifyClient;
-(void)setRequireClientCert:(BOOL)requireClientCert;
-(void)setMsecTimeout:(NSUInteger)msecTimeout;
-(void)setQosType:(pj_qos_type)qosType;
-(void)setQosParams:(pj_qos_params)qosParams;

@end
