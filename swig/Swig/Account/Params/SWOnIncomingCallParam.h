//
//  SWOnIncomingCallParam.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SWSipRxData.h"
#ifdef __cplusplus
#include "pjsua2/account.hpp"
#endif

@interface SWOnIncomingCallParam : NSObject

@property (nonatomic) NSInteger callId;
@property (nonatomic, strong) SWSipRxData *rdata;

#ifdef __cplusplus
+(instancetype)onParamFromParam:(pj::OnIncomingCallParam)param;
#endif

@end
