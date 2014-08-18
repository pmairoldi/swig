//
//  SWOnInstantMessageStatusParam.h
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

@interface SWOnInstantMessageStatusParam: NSObject

@property (nonatomic, strong) NSValue *userData; //void pointer value
@property (nonatomic, strong) NSString *toUri;
@property (nonatomic, strong) NSString *msgBody;
@property (nonatomic) pjsip_status_code code;
@property (nonatomic, strong) NSString *reason;
@property (nonatomic, strong) SWSipRxData *rdata;

#ifdef __cplusplus
+(instancetype)onParamFromParam:(pj::OnInstantMessageStatusParam)param;
#endif

@end