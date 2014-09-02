//
//  NSString+pj_str.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-22.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pjsua.h"

@interface NSString (PJString)

+(NSString *)stringWithPJString:(pj_str_t)PJString;
-(pj_str_t)pjString;

@end
