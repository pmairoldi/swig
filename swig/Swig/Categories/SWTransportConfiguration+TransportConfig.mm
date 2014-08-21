//
//  SWTransportConfiguration+TransportConfig.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-21.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWTransportConfiguration+TransportConfig.h"

@implementation SWTransportConfiguration (TransportConfig)

-(pj::TransportConfig *)toTransportConfig {
    
    pj::TransportConfig *config = new pj::TransportConfig;
    config->port = self.port;
    config->portRange = self.portRange;

    return config;
}

//-(pjsip_transport_type_e)sipTransportType {
//   
//    pjsip_transport_type_e transportType;
//    
//    switch (self.transportType) {
//            
//        case SWTransportTypeUDP:
//            transportType = PJSIP_TRANSPORT_UDP;
//            break;
//            
//        case SWTransportTypeTCP:
//            transportType = PJSIP_TRANSPORT_TCP;
//            break;
//        
//        case SWTransportTypeUDP6:
//            transportType = PJSIP_TRANSPORT_UDP6;
//            break;
//            
//        case SWTransportTypeTCP6:
//            transportType = PJSIP_TRANSPORT_TCP6;
//            break;
//            
//        default:
//            transportType = PJSIP_TRANSPORT_UNSPECIFIED;
//            break;
//    }
//    
//    return transportType;
//}

@end
