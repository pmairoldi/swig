//
//  SWEndpoint.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWEndpointConfiguration.h"
#import "SWTransportConfiguration.h"

@interface SWEndpoint : NSObject

@property (nonatomic, strong) SWEndpointConfiguration *endPointConfiguration;
@property (nonatomic, strong) NSArray *transportConfigurations;

-(void)begin;

@end
