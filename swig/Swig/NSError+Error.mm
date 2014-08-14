//
//  NSError+Error.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "NSError+Error.h"
#import "NSString+String.h"
#import "pjsua2/types.hpp"

@implementation NSError (Error)

+(NSError *)errorFromError:(NSValue *)value {
    
    pj::Error *error = (pj::Error *)[value pointerValue];
    
    NSString *domain = [NSString stringFromCPPString:[NSValue valueWithPointer:&error->title]];
    NSUInteger code = error->status;
    NSDictionary *userInfo = @{@"reason": [NSString stringFromCPPString:[NSValue valueWithPointer:&error->reason]]};
    
    return [NSError errorWithDomain:domain code:code userInfo:userInfo];
}

@end
