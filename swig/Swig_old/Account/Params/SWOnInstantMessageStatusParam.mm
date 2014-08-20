//
//  SWOnInstantMessageStatusParam.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWOnInstantMessageStatusParam.h"
#import "NSString+String.h"

@implementation SWOnInstantMessageStatusParam

-(instancetype)init {
    
    pj::OnInstantMessageStatusParam param;
    
    return [[SWOnInstantMessageStatusParam alloc] initWithParam:param];
}

-(instancetype)initWithParam:(pj::OnInstantMessageStatusParam)param_ {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    pj::OnInstantMessageStatusParam param = param_;
    _userData = [NSValue valueWithPointer:param.userData];
    _toUri = [NSString stringWithCPPString:&param.toUri];
    _msgBody = [NSString stringWithCPPString:&param.msgBody];
    _code = param.code;
    _reason = [NSString stringWithCPPString:&param.reason];
    _rdata = [SWSipRxData sipRxDataFromSipRxData:param.rdata];
    
    return self;
}

+(instancetype)onParamFromParam:(pj::OnInstantMessageStatusParam)param {
    
    return [[SWOnInstantMessageStatusParam alloc] initWithParam:param];
}

@end

