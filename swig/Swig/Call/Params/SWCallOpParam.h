//
//  SWCallOpParams.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWCallSetting.h"
#import "SWSipTxOption.h"

#ifdef __cplusplus
#include "pjsua2/call.hpp"
#endif

@interface SWCallOpParam : NSObject

@property (nonatomic, strong) SWCallSetting *opt;
@property (nonatomic) pjsip_status_code statusCode;
@property (nonatomic, strong) NSString *reason;
@property (nonatomic) NSUInteger options;
@property (nonatomic, strong) SWSipTxOption *txOption;

+(instancetype)defaultSettings;

#ifdef __cplusplus
-(pj::CallOpParam)callOpParam;
#endif

@end
