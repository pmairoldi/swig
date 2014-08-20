//
//  NSError+Error.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "NSError+Error.h"
#import "NSString+String.h"

@implementation NSError (Error)

+(NSError *)errorWithError:(pj::Error *)error {
    
    NSString *domain = [NSString stringWithCPPString:&error->title];
    NSUInteger code = error->status;
    NSDictionary *userInfo = @{@"reason": [NSString stringWithCPPString:&error->reason]};
    
    return [NSError errorWithDomain:domain code:code userInfo:userInfo];
}

@end
