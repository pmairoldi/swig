//
//  SWEndpoint.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-20.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SWEndpointConfiguration;

@interface SWEndpoint : NSObject

/**
 * gets singleton object.
 * @return singleton
 */
+(SWEndpoint*)sharedInstance;
-(BOOL)configure;
-(void)connect;
-(void)disconnect;

@end
