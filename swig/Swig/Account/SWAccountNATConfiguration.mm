//
//  SWAccountNATConfiguration.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWAccountNATConfiguration.h"
#import "NSString+String.h"

@implementation SWAccountNATConfiguration

-(instancetype)init {
    
    pj::AccountNatConfig config;
    return [self initWithAccountNatConfig:config];
}

-(instancetype)initWithAccountNatConfig:(pj::AccountNatConfig)config {
 
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _sipStunUse = config.sipStunUse;
    _mediaStunUse = config.mediaStunUse;
    _iceEnabled = config.iceEnabled;
    _iceMaxHostCands = config.iceMaxHostCands;
    _iceAggressiveNomination = config.iceAggressiveNomination;
    _iceNominatedCheckDelayMsec = config.iceNominatedCheckDelayMsec;
    _iceWaitNominationTimeoutMsec = config.iceWaitNominationTimeoutMsec;
    _iceNoRtcp = config.iceNoRtcp;
    _iceAlwaysUpdate = config.iceAlwaysUpdate;
    _turnEnabled = config.turnEnabled;
    _turnServer = [NSString stringWithCPPString:&config.turnServer];
    _turnConnType = config.turnConnType;
    _turnUserName = [NSString stringWithCPPString:&config.turnUserName];
    _turnPasswordType = config.turnPasswordType;
    _turnPassword = [NSString stringWithCPPString:&config.turnPassword];
    _contactRewriteUse = config.contactRewriteUse;
    _contactRewriteMethod = config.contactRewriteMethod;
    _viaRewriteUse = config.viaRewriteUse;
    _sdpNatRewriteUse = config.sdpNatRewriteUse;
    _sipOutboundUse = config.sipOutboundUse;
    _sipOutboundInstanceId = [NSString stringWithCPPString:&config.sipOutboundInstanceId];
    _sipOutboundRegId = [NSString stringWithCPPString:&config.sipOutboundRegId];
    _udpKaIntervalSec = config.udpKaIntervalSec;
    _udpKaData = [NSString stringWithCPPString:&config.udpKaData];
    
    return self;
}

+(instancetype)natConfigurationFromAccountNatConfig:(pj::AccountNatConfig)config {

    return [[SWAccountNATConfiguration alloc] initWithAccountNatConfig:config];
}

-(pj::AccountNatConfig)config {
    
    pj::AccountNatConfig config;
    config.sipStunUse = self.sipStunUse;
    config.mediaStunUse = self.mediaStunUse;
    config.iceEnabled = self.iceEnabled;
    config.iceMaxHostCands = self.iceMaxHostCands;
    config.iceAggressiveNomination = self.iceAggressiveNomination;
    config.iceNominatedCheckDelayMsec = self.iceNominatedCheckDelayMsec;
    config.iceWaitNominationTimeoutMsec = self.iceWaitNominationTimeoutMsec;
    config.iceNoRtcp = self.iceNoRtcp;
    config.iceAlwaysUpdate = self.iceAlwaysUpdate;
    config.turnEnabled = self.turnEnabled;
    config.turnServer = *[self.turnServer CPPString];
    config.turnConnType = self.turnConnType;
    config.turnUserName = *[self.turnUserName CPPString];
    config.turnPasswordType = self.turnPasswordType;
    config.turnPassword = *[self.turnPassword CPPString];
    config.contactRewriteUse = self.contactRewriteUse;
    config.contactRewriteMethod = self.contactRewriteMethod;
    config.viaRewriteUse = self.viaRewriteUse;
    config.sdpNatRewriteUse = self.sdpNatRewriteUse;
    config.sipOutboundUse = self.sipOutboundUse;
    config.sipOutboundInstanceId = *[self.sipOutboundInstanceId CPPString];
    config.sipOutboundRegId = *[self.sipOutboundRegId CPPString];
    config.udpKaIntervalSec = self.udpKaIntervalSec;
    config.udpKaData = *[self.udpKaData CPPString];
    
    return config;
}

@end
