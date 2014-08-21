//
//  SWTransportConfiguration+TransportConfig.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-21.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWTransportConfiguration.h"

#ifdef __cplusplus
#import "pjsua2.hpp"
#endif

@interface SWTransportConfiguration (TransportConfig)

#ifdef __cplusplus
-(pj::TransportConfig *)toTransportConfig;
#endif

//-(pjsip_transport_type_e)sipTransportType;

@end
