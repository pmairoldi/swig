//
//  SWAccountPresenceConfiguration.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#include <pjsua2/account.hpp>
#endif

@interface SWAccountPresenceConfiguration : NSObject

@property (nonatomic, strong) NSArray *headers;
@property (nonatomic) BOOL publishEnabled;
@property (nonatomic) BOOL publishQueue;
@property (nonatomic) NSUInteger publishShutdownWaitMsec;
@property (nonatomic, strong) NSString *pidfTupleId;

#ifdef __cplusplus
-(pj::AccountPresConfig)config;
#endif

@end
