//
//  NSString+String.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#include <string>
#endif

@interface NSString (String)

#ifdef __cplusplus
+(NSString *)stringWithCPPString:(std::string *)string;
-(std::string *)CPPString;
#endif

@end
