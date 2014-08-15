//
//  SWm
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWMediaConfiguration.h"

@interface SWMediaConfiguration ()

@property (nonatomic) pj::MediaConfig *config;

@end
@implementation SWMediaConfiguration

-(instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _config = new pj::MediaConfig;
    
    return self;
}

-(void)dealloc {
    
    delete _config;
}

-(pj::MediaConfig *)config {
    
    return _config;
}

-(void)setClockRate:(NSUInteger)clockRate {
    
    _config->clockRate = clockRate;
}

-(NSUInteger)clockRate {
    
    return _config->clockRate;
}

-(void)setSndClockRate:(NSUInteger)sndClockRate {
    
    _config->sndClockRate = sndClockRate;
}

-(NSUInteger)sndClockRate {
    
    return _config->sndClockRate;
}

-(void)setChannelCount:(NSUInteger)channelCount {
    
    _config->channelCount = channelCount;
}

-(NSUInteger)channelCount {
    
    return _config->channelCount;
}

-(void)setAudioFramePtime:(NSUInteger)audioFramePtime {
    
    _config->audioFramePtime = audioFramePtime;
}

-(NSUInteger)audioFramePtime{
    
    return _config->audioFramePtime;
}

-(void)setMaxMediaPorts:(NSUInteger)maxMediaPorts{
    
    _config->maxMediaPorts = maxMediaPorts;
}

-(NSUInteger)maxMediaPorts{
    
    return _config->maxMediaPorts;
}

-(void)setHasIoqueue:(BOOL)hasIoqueue{

    _config->hasIoqueue = hasIoqueue;
}

-(BOOL)hasIoqueue{
    
    return _config->hasIoqueue;
}

-(void)setThreadCnt:(NSUInteger)threadCnt{

    _config->threadCnt = threadCnt;
}

-(NSUInteger)threadCnt{
    
    return _config->threadCnt;
}

-(void)setQuality:(NSUInteger)quality{
    
    _config->quality = quality;
}

-(NSUInteger)quality{
    
    return _config->quality;
}

-(void)setPtime:(NSUInteger)ptime{
    
    _config->ptime = ptime;
}

-(NSUInteger)ptime{
    
    return _config->ptime;
}

-(void)setNoVad:(BOOL)noVad{
    
    _config->noVad = noVad;
}

-(BOOL)noVad{
    
    return _config->noVad;
}

-(void)setIlbcMode:(NSUInteger)ilbcMode{
    
    _config->ilbcMode = ilbcMode;
}

-(NSUInteger)ilbcMode{
    
    return _config->ilbcMode;
}

-(void)setTxDropPct:(NSUInteger)txDropPct{

    _config->txDropPct = txDropPct;
}

-(NSUInteger)txDropPct{
    
    return _config->txDropPct;
}

-(void)setRxDropPct:(NSUInteger)rxDropPct{
    
    _config->rxDropPct = rxDropPct;
}
-(NSUInteger)rxDropPct{
    
    return _config->rxDropPct;
}

-(void)setEcOptions:(NSUInteger)ecOptions{
    
    _config->ecOptions = ecOptions;
}

-(NSUInteger)ecOptions{

    return _config->ecOptions;
}

-(void)setEcTailLen:(NSUInteger)ecTailLen{
    
    _config->ecTailLen = ecTailLen;
}

-(NSUInteger)ecTailLen{

    return _config->ecTailLen;
}

-(void)setSndRecLatency:(NSUInteger)sndRecLatency{

    _config->sndRecLatency = sndRecLatency;
}

-(NSUInteger)sndRecLatency{
    
    return _config->sndRecLatency;
}

-(void)setSndPlayLatency:(NSUInteger)sndPlayLatency{
    
    _config->sndPlayLatency = sndPlayLatency;
}

-(NSUInteger)sndPlayLatency{

    return _config->sndPlayLatency;
}

-(void)setJbInit:(NSInteger)jbInit{
    
    _config->jbInit = jbInit;
}

-(NSInteger)jbInit{

    return _config->jbInit;
}

-(void)setJbMinPre:(NSInteger)jbMinPre{
    
    _config->jbMinPre = jbMinPre;
}

-(NSInteger)jbMinPre{
    
    return _config->jbMinPre;
}

-(void)setJbMaxPre:(NSInteger)jbMaxPre{
    
    _config->jbMaxPre = jbMaxPre;
}

-(NSInteger)jbMaxPre{
    
    return _config->jbMaxPre;
}

-(void)setJbMax:(NSInteger)jbMax{
    
    _config->jbMax = jbMax;
}

-(NSInteger)jbMax{
    
    return _config->jbMax;
}

-(void)setSndAutoCloseTime:(NSInteger)sndAutoCloseTime{
    
    _config->sndAutoCloseTime = sndAutoCloseTime;
}

-(NSInteger)sndAutoCloseTime{
    
    return _config->sndAutoCloseTime;
}

-(void)setVidPreviewEnableNative:(BOOL)vidPreviewEnableNative{
    
    _config->vidPreviewEnableNative = vidPreviewEnableNative;
}

-(BOOL)vidPreviewEnableNative{

    return _config->vidPreviewEnableNative;
}

@end
