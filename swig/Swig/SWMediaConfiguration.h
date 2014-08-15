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

//getters
#ifdef __cplusplus
-(pj::MediaConfig *)config;
#endif
-(NSUInteger)clockRate;
-(NSUInteger)sndClockRate;
-(NSUInteger)channelCount;
-(NSUInteger)audioFramePtime;
-(NSUInteger)maxMediaPorts;
-(BOOL)hasIoqueue;
-(NSUInteger)threadCnt;
-(NSUInteger)quality;
-(NSUInteger)ptime;
-(BOOL)noVad;
-(NSUInteger)ilbcMode;
-(NSUInteger)txDropPct;
-(NSUInteger)rxDropPct;
-(NSUInteger)ecOptions;
-(NSUInteger)ecTailLen;
-(NSUInteger)sndRecLatency;
-(NSUInteger)sndPlayLatency;
-(NSInteger)jbInit;
-(NSInteger)jbMinPre;
-(NSInteger)jbMaxPre;
-(NSInteger)jbMax;
-(NSInteger)sndAutoCloseTime;
-(BOOL)vidPreviewEnableNative;

//setters
-(void)setClockRate:(NSUInteger)clockRate;
-(void)setSndClockRate:(NSUInteger)sndClockRate;
-(void)setChannelCount:(NSUInteger)channelCount;
-(void)setAudioFramePtime:(NSUInteger)audioFramePtime;
-(void)setMaxMediaPorts:(NSUInteger)maxMediaPorts;
-(void)setHasIoqueue:(BOOL)hasIoqueue;
-(void)setThreadCnt:(NSUInteger)threadCnt;
-(void)setQuality:(NSUInteger)quality;
-(void)setPtime:(NSUInteger)ptime;
-(void)setNoVad:(BOOL)noVad;
-(void)setIlbcMode:(NSUInteger)ilbcMode;
-(void)setTxDropPct:(NSUInteger)txDropPct;
-(void)setRxDropPct:(NSUInteger)rxDropPct;
-(void)setEcOptions:(NSUInteger)ecOptions;
-(void)setEcTailLen:(NSUInteger)ecTailLen;
-(void)setSndRecLatency:(NSUInteger)sndRecLatency;
-(void)setSndPlayLatency:(NSUInteger)sndPlayLatency;
-(void)setJbInit:(NSInteger)jbInit;
-(void)setJbMinPre:(NSInteger)jbMinPre;
-(void)setJbMaxPre:(NSInteger)jbMaxPre;
-(void)setJbMax:(NSInteger)jbMax;
-(void)setSndAutoCloseTime:(NSInteger)sndAutoCloseTime;
-(void)setVidPreviewEnableNative:(BOOL)vidPreviewEnableNative;

@end
