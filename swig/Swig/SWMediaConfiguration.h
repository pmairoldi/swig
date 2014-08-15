//
//  SWMediaConfiguration.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#include "pjsua2/endpoint.hpp"
#endif

@interface SWMediaConfiguration : NSObject

@property (nonatomic) NSUInteger clockRate;
@property (nonatomic) NSUInteger sndClockRate;
@property (nonatomic) NSUInteger channelCount;
@property (nonatomic) NSUInteger audioFramePtime;
@property (nonatomic) NSUInteger maxMediaPorts;
@property (nonatomic) BOOL hasIoqueue;
@property (nonatomic) NSUInteger threadCnt;
@property (nonatomic) NSUInteger quality;
@property (nonatomic) NSUInteger ptime;
@property (nonatomic) BOOL noVad;
@property (nonatomic) unsigned ilbcMode;
@property (nonatomic) NSUInteger txDropPct;
@property (nonatomic) NSUInteger rxDropPct;
@property (nonatomic) NSUInteger ecOptions;
@property (nonatomic) NSUInteger ecTailLen;
@property (nonatomic) NSUInteger sndRecLatency;
@property (nonatomic) NSUInteger sndPlayLatency;
@property (nonatomic) NSInteger jbInit;
@property (nonatomic) NSInteger jbMinPre;
@property (nonatomic) NSInteger jbMaxPre;
@property (nonatomic) NSInteger jbMax;
@property (nonatomic) NSInteger sndAutoCloseTime;
@property (nonatomic) BOOL vidPreviewEnableNative;

#ifdef __cplusplus
-(pj::MediaConfig)config;
#endif

@end
