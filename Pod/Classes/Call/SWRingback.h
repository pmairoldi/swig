//
//  SWRingback.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-27.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <pjsua.h>
#import "SWPlayableProtocol.h"

@interface SWRingback : NSObject <SWPlayableProtocol>

@property (nonatomic, readonly) NSInteger ringbackSlot;
@property (nonatomic, readonly) pjmedia_port *ringbackPort;

@end
