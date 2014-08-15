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

+(NSString *)stringFromCPPString:(std::string *)string {
    
    return [NSString stringWithCString:string->c_str() encoding:NSUTF8StringEncoding];
}

-(std::string *)CPPString {
    
    std::string *string = new std::string([self UTF8String]);
    
    return string;
}

@end
