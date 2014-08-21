//
//  SWTransportConfigurations.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-20.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "pjsip/sip_types.h"

typedef NS_ENUM(NSUInteger, SWTransportType) {
    SWTransportTypeUDP = PJSIP_TRANSPORT_UDP,
    SWTransportTypeTCP = PJSIP_TRANSPORT_TCP,
    SWTransportTypeUDP6 = PJSIP_TRANSPORT_UDP6,
    SWTransportTypeTCP6 = PJSIP_TRANSPORT_TCP6
};

@interface SWTransportConfiguration : NSObject

@property (nonatomic) SWTransportType transportType;
@property (nonatomic) NSUInteger port; //5060 is default
@property (nonatomic) NSUInteger portRange; //0 is default
//@property (nonatomic, strong) NSString *publicAddress;
//@property (nonatomic, strong) NSString *boundAddress;
//@property (nonatomic, strong) TLSConfig *tls;

+(instancetype)configurationWithTransportType:(SWTransportType)transportType;

@end
