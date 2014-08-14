//
//  SWMediaConfiguration.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWMediaConfiguration.h"
#import "PJSUA2.h"

@implementation SWMediaConfiguration

-(instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    MediaConfig config;
    
    _clockRate = config.clockRate;
    _sndClockRate = config.sndClockRate;
    _channelCount = config.channelCount;
    _audioFramePtime = config.audioFramePtime;
    _maxMediaPorts = config.maxMediaPorts;
    _hasIoqueue = config.hasIoqueue;
    _threadCnt = config.threadCnt;
    _quality = config.quality;
    _ptime = config.ptime;
    _noVad = config.noVad;
    _ilbcMode = config.ilbcMode;
    _txDropPct = config.txDropPct;
    _rxDropPct = config.rxDropPct;
    _ecOptions = config.ecOptions;
    _ecTailLen = config.ecTailLen;
    _sndRecLatency = config.sndRecLatency;
    _sndPlayLatency = config.sndPlayLatency;
    _jbInit = config.jbInit;
    _jbMinPre = config.jbMinPre;
    _jbMaxPre = config.jbMaxPre;
    _jbMax = config.jbMax;
    _sndAutoCloseTime = config.sndAutoCloseTime;
    _vidPreviewEnableNative = config.vidPreviewEnableNative;
    
    return self;
}

@end
