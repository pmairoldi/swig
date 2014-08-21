//
//  SWUriFormatter.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-21.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWUriFormatter.h"

@implementation SWUriFormatter

+(NSString *)sipUri:(NSString *)uri {
    
    NSString *sipUri = uri;
    
    if ([sipUri rangeOfString:@"sip:"].location == NSNotFound) {
        sipUri = [NSString stringWithFormat:@"sip:%@", sipUri];
    }
    
    return sipUri;
}

@end
