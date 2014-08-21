//
//  SWAccountConfiguration+AccountConfig.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-21.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWAccountConfiguration.h"

#ifdef __cplusplus
#import "pjsua2.hpp"
#endif

@interface SWAccountConfiguration (AccountConfig)

#ifdef __cplusplus
-(pj::AccountConfig *)toAccountConfig;
#endif

@end
