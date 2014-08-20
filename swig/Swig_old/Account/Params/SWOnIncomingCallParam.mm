//
//  SWOnIncomingCallParam.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWOnIncomingCallParam.h"

@implementation SWOnIncomingCallParam

-(instancetype)init {
    
    pj::OnIncomingCallParam param;
    
    return [[SWOnIncomingCallParam alloc] initWithParam:param];
}

-(instancetype)initWithParam:(pj::OnIncomingCallParam)param_ {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    pj::OnIncomingCallParam param = param_;
    _callId = param.callId;
    _rdata = [SWSipRxData sipRxDataFromSipRxData:param.rdata];
    
    return self;
}

+(instancetype)onParamFromParam:(pj::OnIncomingCallParam)param {
    
    return [[SWOnIncomingCallParam alloc] initWithParam:param];
}

@end