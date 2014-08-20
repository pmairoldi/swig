//
//  SWAccountVideoConfiguration.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#include <pjsua2/account.hpp>
#endif

@interface SWAccountVideoConfiguration : NSObject

@property (nonatomic) BOOL autoShowIncoming;
@property (nonatomic) BOOL autoTransmitOutgoing;
@property (nonatomic) NSUInteger windowFlags;
@property (nonatomic) pjmedia_vid_dev_index defaultCaptureDevice;
@property (nonatomic) pjmedia_vid_dev_index defaultRenderDevice;
@property (nonatomic) pjmedia_vid_stream_rc_method rateControlMethod;
@property (nonatomic) NSUInteger rateControlBandwidth;

#ifdef __cplusplus
+(instancetype)videoConfigurationFromAccountVideoConfig:(pj::AccountVideoConfig)config;
-(pj::AccountVideoConfig)config;
#endif

@end
