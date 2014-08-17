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

@end

@implementation SWTlsConfig

-(instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    pj::TlsConfig config;
    
    self.CaListFile = [NSString stringWithCPPString:&config.CaListFile];
    self.certFile = [NSString stringWithCPPString:&config.certFile];
    self.privKeyFile = [NSString stringWithCPPString:&config.privKeyFile];
    self.password = [NSString stringWithCPPString:&config.password];
    self.method = config.method;
    self.ciphers = [NSArray arrayWithIntVector:&config.ciphers];
    self.verifyServer = config.verifyServer;
    self.verifyClient = config.verifyClient;
    self.requireClientCert = config.requireClientCert;
    self.msecTimeout = config.msecTimeout;
    self.qosType = config.qosType;
    self.qosParams = config.qosParams;
    
    return self;
}

-(pj::TlsConfig)config {
    
    pj::TlsConfig config;

    config.CaListFile = *[self.CaListFile CPPString];
    config.certFile = *[self.certFile CPPString];
    config.privKeyFile = *[self.privKeyFile CPPString];
    config.password = *[self.password CPPString];
    config.method = self.method;
    config.ciphers = *[self.ciphers intVector];
    config.verifyServer = self.verifyServer;
    config.verifyClient = self.verifyClient;
    config.requireClientCert = self.requireClientCert;
    config.msecTimeout = self.msecTimeout;
    config.qosType = self.qosType;
    config.qosParams = self.qosParams;
    
    return config;
}

@end
