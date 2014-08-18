//
//  SWOnMwiInfoParam.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#include "pjsua2/account.hpp"
#endif

#import "pjsip-simple/evsub.h"

@class SWSipRxData;

@interface SWOnMwiInfoParam: NSObject

@property (nonatomic) pjsip_evsub_state state;
@property (nonatomic, strong) SWSipRxData *rdata;

#ifdef __cplusplus
+(instancetype)onParamFromParam:(pj::OnMwiInfoParam)param;
#endif

@end