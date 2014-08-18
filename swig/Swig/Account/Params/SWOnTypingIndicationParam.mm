//
//  SWOnTypingIndicationParam.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWOnTypingIndicationParam.h"
#import "NSString+String.h"

@implementation SWOnTypingIndicationParam

-(instancetype)init {
    
    pj::OnTypingIndicationParam param;
    
    return [[SWOnTypingIndicationParam alloc] initWithParam:param];
}

-(instancetype)initWithParam:(pj::OnTypingIndicationParam)param_ {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    pj::OnTypingIndicationParam param = param_;
    _fromUri = [NSString stringWithCPPString:&param.fromUri];
    _toUri = [NSString stringWithCPPString:&param.toUri];
    _contactUri = [NSString stringWithCPPString:&param.contactUri];
    _isTyping = param.isTyping;
    _rdata = [SWSipRxData sipRxDataFromSipRxData:param.rdata];
    
    return self;
}

+(instancetype)onParamFromParam:(pj::OnTypingIndicationParam)param {
    
    return [[SWOnTypingIndicationParam alloc] initWithParam:param];
}

@end

