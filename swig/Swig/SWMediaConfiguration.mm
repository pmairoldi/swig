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

    config.clockRate = self.clockRate;
    config.sndClockRate = self.sndClockRate;
    config.channelCount = self.channelCount;
    config.audioFramePtime = self.audioFramePtime;
    config.maxMediaPorts = self.maxMediaPorts;
    config.hasIoqueue = self.hasIoqueue;
    config.threadCnt = self.threadCnt;
    config.quality = self.quality;
    config.ptime = self.ptime;
    config.noVad = self.noVad;
    config.ilbcMode = self.ilbcMode;
    config.txDropPct = self.txDropPct;
    config.rxDropPct = self.rxDropPct;
    config.ecOptions = self.ecOptions;
    config.ecTailLen = self.ecTailLen;
    config.sndRecLatency = self.sndRecLatency;
    config.sndPlayLatency = self.sndPlayLatency;
    config.jbInit = self.jbInit;
    config.jbMinPre = self.jbMinPre;
    config.jbMaxPre = self.jbMaxPre;
    config.jbMax = self.jbMax;
    config.sndAutoCloseTime = self.sndAutoCloseTime;
    config.vidPreviewEnableNative = self.vidPreviewEnableNative;
    
    return config;
}

@end
