//
//  SWm
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWMediaConfiguration.h"

@interface SWMediaConfiguration ()

@end

@implementation SWMediaConfiguration

-(instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    pj::MediaConfig config;
    
    self.clockRate = config.clockRate;
    self.sndClockRate = config.sndClockRate;
    self.channelCount = config.channelCount;
    self.audioFramePtime = config.audioFramePtime;
    self.maxMediaPorts = config.maxMediaPorts;
    self.hasIoqueue = config.hasIoqueue;
    self.threadCnt = config.threadCnt;
    self.quality = config.quality;
    self.ptime = config.ptime;
    self.noVad = config.noVad;
    self.ilbcMode = config.ilbcMode;
    self.txDropPct = config.txDropPct;
    self.rxDropPct = config.rxDropPct;
    self.ecOptions = config.ecOptions;
    self.ecTailLen = config.ecTailLen;
    self.sndRecLatency = config.sndRecLatency;
    self.sndPlayLatency = config.sndPlayLatency;
    self.jbInit = config.jbInit;
    self.jbMinPre = config.jbMinPre;
    self.jbMaxPre = config.jbMaxPre;
    self.jbMax = config.jbMax;
    self.sndAutoCloseTime = config.sndAutoCloseTime;
    self.vidPreviewEnableNative = config.vidPreviewEnableNative;
    
    return self;
}

-(pj::MediaConfig)config {
    
    pj::MediaConfig config;

    config.clockRate = (unsigned int)self.clockRate;
    config.sndClockRate = (unsigned int)self.sndClockRate;
    config.channelCount = (unsigned int)self.channelCount;
    config.audioFramePtime = (unsigned int)self.audioFramePtime;
    config.maxMediaPorts = (unsigned int)self.maxMediaPorts;
    config.hasIoqueue = self.hasIoqueue;
    config.threadCnt = (unsigned int)self.threadCnt;
    config.quality = (unsigned int)self.quality;
    config.ptime = (unsigned int)self.ptime;
    config.noVad = self.noVad;
    config.ilbcMode = self.ilbcMode;
    config.txDropPct = (unsigned int)self.txDropPct;
    config.rxDropPct = (unsigned int)self.rxDropPct;
    config.ecOptions = (unsigned int)self.ecOptions;
    config.ecTailLen = (unsigned int)self.ecTailLen;
    config.sndRecLatency = (unsigned int)self.sndRecLatency;
    config.sndPlayLatency = (unsigned int)self.sndPlayLatency;
    config.jbInit = (int)self.jbInit;
    config.jbMinPre = (int)self.jbMinPre;
    config.jbMaxPre = (int)self.jbMaxPre;
    config.jbMax = (int)self.jbMax;
    config.sndAutoCloseTime = (int)self.sndAutoCloseTime;
    config.vidPreviewEnableNative = self.vidPreviewEnableNative;
    
    return config;
}

@end
