//
//  SWEndpointConfiguration+EpConfig.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-21.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWEndpointConfiguration.h"

#ifdef __cplusplus
#import "pjsua2.hpp"
#endif

@interface SWEndpointConfiguration (EpConfig)

#ifdef __cplusplus
-(pj::EpConfig *)toEpConfig;
#endif

@end
