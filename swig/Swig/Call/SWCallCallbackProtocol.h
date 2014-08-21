//
//  SWCallCallbackProtocol.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-21.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWCall.h"

@protocol SWCallCallbackProtocol <NSObject>

-(void)onCallState:(SWCallState)callState;

@end
