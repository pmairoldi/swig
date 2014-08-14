//
//  NSString+String.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "NSString+String.h"
#import <string>

@implementation NSString (String)

+(NSString *)stringFromCPPString:(NSValue *)string {
    
   std::string *stringValue = (std::string *)[string pointerValue];

    return [NSString stringWithCString:stringValue->c_str() encoding:NSUTF8StringEncoding];
}

-(NSValue *)CPPString {
    
    std::string *cppString = new std::string([self UTF8String]);
    
    return [NSValue valueWithPointer:cppString];
}

@end
