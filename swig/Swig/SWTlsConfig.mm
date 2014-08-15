//
//  SWTlsConfig.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWTlsConfig.h"
#import "NSString+String.h"
#import "NSArray+IntVector.h"

@interface SWTlsConfig ()

@property (nonatomic) pj::TlsConfig *config;

@end

@implementation SWTlsConfig

-(instancetype)init {
    
    pj::TlsConfig *config = new pj::TlsConfig;
    
    return [self initWithConfig:config];
}

-(instancetype)initWithConfig:(pj::TlsConfig *)config {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _config = config;
    
    self.CaListFile = @"test";
    
    return self;
}

-(void)dealloc {
    
    delete _config;
}

-(pj::TlsConfig *)config {
    
    return _config;
}

//getters
-(void)setCaListFile:(NSString *)CaListFile{
 
    _config->CaListFile = *[CaListFile CPPString];
}

-(NSString *)CaListFile{
 
    return [NSString stringFromCPPString:&_config->CaListFile];
}

-(void)setCertFile:(NSString *)certFile{
 
    _config->certFile = *[certFile CPPString];
}

-(NSString *)certFile{
    
    return [NSString stringFromCPPString:&_config->certFile];
}

-(void)setPrivKeyFile:(NSString *)privKeyFile{
    
    _config->privKeyFile = *[privKeyFile CPPString];
}

-(NSString *)privKeyFile{
    
    return [NSString stringFromCPPString:&_config->privKeyFile];
}

-(void)setPasswordFile:(NSString *)password{
    
    _config->privKeyFile = *[password CPPString];
}

-(NSString *)password{
    
    return [NSString stringFromCPPString:&_config->password];
}

-(void)setMethod:(pjsip_ssl_method)method{
    
    _config->method = method;
}

-(pjsip_ssl_method)method{
    
    return _config->method;
}

-(void)setCiphers:(NSArray *)ciphers{
    
    _config->ciphers = *[ciphers intVector];
}

-(NSArray *)ciphers{
    
    return [NSArray arrayWithIntVector:&_config->ciphers];
}

-(void)setVerifyServer:(BOOL)verifyServer{
    
    _config->verifyServer = verifyServer;
}

-(BOOL)verifyServer{
    
    return _config->verifyServer;
}

-(void)setVerifyClient:(BOOL)verifyClient {
    
    _config->verifyClient = verifyClient;
}

-(BOOL)verifyClient{
    
    return _config->verifyClient;
}

-(void)setRequireClientCert:(BOOL)requireClientCert{
    
    _config->requireClientCert = requireClientCert;
}

-(BOOL)requireClientCert{
 
    return _config->requireClientCert;
}

-(void)setMsecTimeout:(NSUInteger)msecTimeout{
    
    _config->msecTimeout = msecTimeout;
}

-(NSUInteger)msecTimeout{
    
    return _config->msecTimeout;
}

-(void)setQosType:(pj_qos_type)qosType{
    
    _config->qosType = qosType;
}

-(pj_qos_type)qosType{
    
    return _config->qosType;
}

-(void)setQosParams:(pj_qos_params)qosParams{
    
    _config->qosParams = qosParams;
}

-(pj_qos_params)qosParams{
    
    return _config->qosParams;
}

@end
