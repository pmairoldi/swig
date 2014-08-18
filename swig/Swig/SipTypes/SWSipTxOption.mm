//
//  SWSipTxOption.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWSipTxOption.h"
#import "NSString+String.h"
#import "NSArray+SipHeaderVector.h"
#import "NSArray+SipMultipartPartVector.h"

@implementation SWSipTxOption

-(instancetype)init {
    
    pj::SipTxOption sipTxOption;
    
    return [self initWithSipTxOption:sipTxOption];
}

-(instancetype)initWithSipTxOption:(pj::SipTxOption)sipTxOption_ {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    pj::SipTxOption sipTxOption = sipTxOption_;
    _targetUri = [NSString stringWithCPPString:&sipTxOption.targetUri];
    _headers = [NSArray arrayWithSipHeaderVector:&sipTxOption.headers];
    _contentType = [NSString stringWithCPPString:&sipTxOption.contentType];
    _msgBody = [NSString stringWithCPPString:&sipTxOption.msgBody];
    _multipartContentType = [SWSipMediaType sipMediaTypeFromSipMediaType:sipTxOption.multipartContentType];
    _multipartParts = [NSArray arrayWithSipMultipartPartVector:&sipTxOption.multipartParts];
    
    return self;
}

+(instancetype)sipTxOptionFromSipTxOption:(pj::SipTxOption)sipTxOption {
    
    return [[SWSipTxOption alloc] initWithSipTxOption:sipTxOption];
}

-(pj::SipTxOption)sipTxOption {
    
    pj::SipTxOption sipTxOption;
    sipTxOption.targetUri = *[self.targetUri CPPString];
    sipTxOption.headers = *[self.headers sipHeaderVector];
    sipTxOption.contentType =  *[self.contentType CPPString];
    sipTxOption.msgBody = *[self.msgBody CPPString];
    sipTxOption.multipartContentType = [self.multipartContentType sipMediaType];
    sipTxOption.multipartParts = *[self.multipartParts sipMultipartPartVector];
    
    return sipTxOption;
}

@end
