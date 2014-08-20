//
//  SWOnRegStateParam.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWOnRegStateParam.h"
#import "NSString+String.h"

@implementation SWOnRegStateParam

-(instancetype)init {
    
    pj::OnRegStateParam param;
    
    return [[SWOnRegStateParam alloc] initWithParam:param];
}

-(instancetype)initWithParam:(pj::OnRegStateParam)param_ {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    pj::OnRegStateParam param = param_;
    _status = param.status;
    _code = param.code;
    _reason = [NSString stringWithCPPString:&param.reason];
    _rdata = [SWSipRxData sipRxDataFromSipRxData:param.rdata];
    _expiration = param.expiration;
    
    return self;
}

+(instancetype)onParamFromParam:(pj::OnRegStateParam)param {
    
    return [[SWOnRegStateParam alloc] initWithParam:param];
}

@end
