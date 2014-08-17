//
//  SWAccountVideoConfiguration.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWAccountVideoConfiguration.h"

@implementation SWAccountVideoConfiguration

-(instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    pj::AccountVideoConfig config;
    _autoShowIncoming = config.autoShowIncoming;
    _autoTransmitOutgoing = config.autoTransmitOutgoing;
    _windowFlags = config.windowFlags;
    _defaultCaptureDevice = config.defaultCaptureDevice;
    _defaultRenderDevice = config.defaultRenderDevice;
    _rateControlMethod = config.rateControlMethod;
    _rateControlBandwidth = config.rateControlBandwidth;
    
    return self;
}

-(pj::AccountVideoConfig)config {
    
    pj::AccountVideoConfig config;
    config.autoShowIncoming = self.autoShowIncoming;
    config.autoTransmitOutgoing = self.autoTransmitOutgoing;
    config.windowFlags = self.windowFlags;
    config.defaultCaptureDevice = self.defaultCaptureDevice;
    config.defaultRenderDevice = self.defaultRenderDevice;
    config.rateControlMethod = self.rateControlMethod;
    config.rateControlBandwidth = self.rateControlBandwidth;
    
    return config;
}

@end
