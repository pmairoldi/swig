//
//  SWSipMultipartPart.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWSipMultipartPart.h"
#import "NSArray+SipHeaderVector.h"
#import "NSString+String.h"

@implementation SWSipMultipartPart

-(instancetype)init {
    
    pj::SipMultipartPart sipMultipartPart;
    
    return [self initWithSipMultipartPart:sipMultipartPart];
}

-(instancetype)initWithSipMultipartPart:(pj::SipMultipartPart)sipMultipartPart_ {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    pj::SipMultipartPart sipMultipartPart = sipMultipartPart_;
    _headers = [NSArray arrayWithSipHeaderVector:&sipMultipartPart.headers];
    _contentType = [SWSipMediaType sipMediaTypeFromSipMediaType:sipMultipartPart.contentType];
    _body = [NSString stringWithCPPString:&sipMultipartPart.body];
    
    return self;
}

+(instancetype)sipMultipartPartFromSipMultipartPart:(pj::SipMultipartPart)sipMultipartPart {
    
    return [[SWSipMultipartPart alloc] initWithSipMultipartPart:sipMultipartPart];
}

-(pj::SipMultipartPart)sipMultipartPart {
    
    pj::SipMultipartPart sipMultipartPart;
    sipMultipartPart.headers = *[self.headers sipHeaderVector];
    sipMultipartPart.contentType = [self.contentType sipMediaType];
    sipMultipartPart.body = *[self.body CPPString];
    
    return sipMultipartPart;
}

@end
