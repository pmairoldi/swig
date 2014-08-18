//
//  SWOnInstantMessageParam.h
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

@interface SWOnInstantMessageParam: NSObject

@property (nonatomic, strong) NSString *fromUri;
@property (nonatomic, strong) NSString *toUri;
@property (nonatomic, strong) NSString *contactUri;
@property (nonatomic, strong) NSString *contentType;
@property (nonatomic, strong) NSString *msgBody;
@property (nonatomic, strong) SWSipRxData *rdata;

#ifdef __cplusplus
+(instancetype)onParamFromParam:(pj::OnInstantMessageParam)param;
#endif

@end
