//
//  NSString+pj_str.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-22.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "NSString+PJString.h"

@implementation NSString (PJString)

+ (NSString *)stringWithPJString:(pj_str_t)pjString {
    
    return [[NSString alloc] initWithBytes:pjString.ptr length:(NSUInteger)pjString.slen encoding:NSUTF8StringEncoding];
}

- (pj_str_t)pjString {
    
    return pj_str((char *)[self cStringUsingEncoding:NSUTF8StringEncoding]);
}

@end
