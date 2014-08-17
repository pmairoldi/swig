//
//  SWAccountMWIConfiguration.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#include <pjsua2/account.hpp>
#endif

@interface SWAccountMWIConfiguration : NSObject

@property (nonatomic) BOOL enabled;
@property (nonatomic) NSUInteger expirationSec;

#ifdef __cplusplus
-(pj::AccountMwiConfig)config;
#endif

@end
