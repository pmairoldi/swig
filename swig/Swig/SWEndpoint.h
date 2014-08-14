//
//  SWEndpoint.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWUserAgentConfiguration.h"
#import "SWLogConfiguration.h"
#import "SWMediaConfiguration.h"
#import "SWTransportConfiguration.h"

@interface SWEndpoint : NSObject

@property (nonatomic, strong) SWUserAgentConfiguration *userAgentConfiguration;
@property (nonatomic, strong) SWLogConfiguration *logConfiguration;
@property (nonatomic, strong) SWMediaConfiguration *mediaConfiguration;
@property (nonatomic, strong) NSArray *transportConfigurations;

-(void)begin;

@end
