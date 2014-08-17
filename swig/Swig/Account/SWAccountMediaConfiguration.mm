//
//  SWAccountMediaConfiguration.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWAccountMediaConfiguration.h"

@implementation SWAccountMediaConfiguration

-(instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    pj::AccountMediaConfig config;
    _transportConfig = [SWTransportConfiguration new];
    _lockCodecEnabled = config.lockCodecEnabled;
    _streamKaEnabled = config.streamKaEnabled;
    _srtpUse = config.srtpUse;
    _srtpSecureSignaling = config.srtpSecureSignaling;
    _ipv6Use = config.ipv6Use;
    
    return self;
}

-(pj::AccountMediaConfig)config {
    
    pj::AccountMediaConfig config;
    config.transportConfig = self.transportConfig.config;
    config.lockCodecEnabled = self.lockCodecEnabled;
    config.streamKaEnabled = self.streamKaEnabled;
    config.srtpUse = self.srtpUse;
    config.srtpSecureSignaling = self.srtpSecureSignaling;
    config.ipv6Use = self.ipv6Use;
    
    return config;
}

@end
