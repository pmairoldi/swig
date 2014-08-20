//
//  SWOnRegStateParam.h
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

@interface SWOnRegStateParam: NSObject

@property (nonatomic) pj_status_t status;
@property (nonatomic) pjsip_status_code code;
@property (nonatomic, strong) NSString *reason;
@property (nonatomic, strong) SWSipRxData *rdata;
@property (nonatomic) NSInteger expiration;

#ifdef __cplusplus
+(instancetype)onParamFromParam:(pj::OnRegStateParam)param;
#endif

@end
