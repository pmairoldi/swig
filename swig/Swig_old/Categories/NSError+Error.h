//
//  NSError+Error.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#import "pjsua2/types.hpp"
#endif

@interface NSError (Error)

#ifdef __cplusplus
+(NSError *)errorWithError:(pj::Error *)error;
#endif

@end
