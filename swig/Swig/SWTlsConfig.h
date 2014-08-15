//
//  SWTlsConfig.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pjsip/sip_types.h"

#ifdef __cplusplus
#include "pjsua2/siptypes.hpp"
#endif

@interface SWTlsConfig : NSObject

#ifdef __cplusplus
-(instancetype)initWithConfig:(pj::TlsConfig *)config;
#endif

//getters
#ifdef __cplusplus
-(pj::TlsConfig *)config;
#endif

//setters

//TODO: add other fields

@end
