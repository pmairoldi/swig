//
//  SipHeader.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-17.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWSipHeader.h"
#import "NSString+String.h"

@implementation SWSipHeader

-(instancetype)init {
    
    pj::SipHeader sipHeader;
    
    return [self initWithSipHeader:sipHeader];
}

-(instancetype)initWithSipHeader:(pj::SipHeader)sipHeader {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _hName = [NSString stringWithCPPString:&sipHeader.hName];
    _hValue = [NSString stringWithCPPString:&sipHeader.hValue];
    
    return self;
}

+(instancetype)sipHeaderFromSipHeader:(pj::SipHeader)sipHeader {
    
    return [[SWSipHeader alloc] initWithSipHeader:sipHeader];
}

-(pj::SipHeader)sipHeader {
    
    pj::SipHeader sipHeader;
    sipHeader.hName = *[self.hName CPPString];
    sipHeader.hValue = *[self.hValue CPPString];
    
    return sipHeader;
}

@end
