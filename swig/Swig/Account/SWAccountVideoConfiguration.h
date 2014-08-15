//
//  SWAccountVideoConfiguration.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#include <pjsua2/account.hpp>
#endif

@interface SWAccountVideoConfiguration : NSObject

#ifdef __cplusplus
-(pj::AccountVideoConfig)config;
#endif

@end
