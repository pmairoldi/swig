//
//  NSString+String.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (String)

+(NSString *)stringFromCPPString:(NSValue *)string;
-(NSValue *)CPPString;

@end
