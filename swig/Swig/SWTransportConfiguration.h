//
//  SWTransportConfiguration.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pjsip/sip_types.h"

@interface SWTransportConfiguration : NSObject

@property (nonatomic) NSUInteger port;
@property (nonatomic) NSUInteger portRange;
@property (nonatomic, strong) NSString *publicAddress;
@property (nonatomic, strong) NSString *boundAddress;
//@property (nonatomic) TlsConfig //warning add
//@property (nonatomic) pj_qos_type
//@property (nonatomic) pj_qos_type
@property (nonatomic) pjsip_transport_type_e transportType;

-(instancetype)initWithPort:(NSUInteger)port;

@end
