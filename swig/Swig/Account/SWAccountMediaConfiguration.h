//
//  SWAccountMediaConfiguration.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#include <pjsua2/account.hpp>
#endif
#import "SWTransportConfiguration.h"

@interface SWAccountMediaConfiguration : NSObject

@property (nonatomic, strong) SWTransportConfiguration *transportConfig;
@property (nonatomic) BOOL lockCodecEnabled;
@property (nonatomic) BOOL streamKaEnabled;
@property (nonatomic) pjmedia_srtp_use srtpUse;
@property (nonatomic) NSInteger srtpSecureSignaling;
@property (nonatomic) pjsua_ipv6_use ipv6Use;

#ifdef __cplusplus
-(pj::AccountMediaConfig)config;
#endif

@end
