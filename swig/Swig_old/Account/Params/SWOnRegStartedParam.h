//
//  SWOnRegStartedParam.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#include "pjsua2/account.hpp"
#endif

@interface SWOnRegStartedParam: NSObject

@property (nonatomic) BOOL renew;

#ifdef __cplusplus
+(instancetype)onParamFromParam:(pj::OnRegStartedParam)param;
#endif

@end