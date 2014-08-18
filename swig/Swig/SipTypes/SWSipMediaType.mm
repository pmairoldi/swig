//
//  SWSipMediaType.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWSipMediaType.h"
#import "NSString+String.h"

@implementation SWSipMediaType

-(instancetype)init {
    
    pj::SipMediaType sipMediaType;
    
    return [self initWithSipMediaType:sipMediaType];
}

-(instancetype)initWithSipMediaType:(pj::SipMediaType)sipMediaType_ {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    pj::SipMediaType sipMediaType = sipMediaType_;
    _type = [NSString stringWithCPPString:&sipMediaType.type];
    _subType = [NSString stringWithCPPString:&sipMediaType.subType];
    
    return self;
}

+(instancetype)sipMediaTypeFromSipMediaType:(pj::SipMediaType)sipMediaType {
    
    return [[SWSipMediaType alloc] initWithSipMediaType:sipMediaType];
}

-(pj::SipMediaType)sipMediaType {
    
    pj::SipMediaType sipMediaType;
    sipMediaType.type = *[self.type CPPString];
    sipMediaType.subType = *[self.subType CPPString];
    
    return sipMediaType;
}

@end
