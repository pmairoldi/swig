//
//  SWOnIncomingSubscribeParam.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SWSipRxData.h"
#import "SWSipTxOption.h"
#ifdef __cplusplus
#include "pjsua2/account.hpp"
#endif

@interface SWOnIncomingSubscribeParam: NSObject

@property (nonatomic, strong) NSValue *srvPres; //pointer value
@property (nonatomic, strong) NSString *fromUri;
@property (nonatomic, strong) SWSipRxData *rdata;
@property (nonatomic) pjsip_status_code code;
@property (nonatomic, strong) NSString *reason;
@property (nonatomic, strong) SWSipTxOption *txOption;

#ifdef __cplusplus
+(instancetype)onParamFromParam:(pj::OnIncomingSubscribeParam)param;
#endif

@end
