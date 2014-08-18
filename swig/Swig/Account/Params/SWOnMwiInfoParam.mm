//
//  SWOnMwiInfoParam.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWOnMwiInfoParam.h"

@implementation SWOnMwiInfoParam

-(instancetype)init {
    
    pj::OnMwiInfoParam param;
    
    return [[SWOnMwiInfoParam alloc] initWithParam:param];
}

-(instancetype)initWithParam:(pj::OnMwiInfoParam)param_ {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    pj::OnMwiInfoParam param = param_;
    _state = param.state;
    _rdata = [SWSipRxData sipRxDataFromSipRxData:param.rdata];

    return self;
}

+(instancetype)onParamFromParam:(pj::OnMwiInfoParam)param {
    
    return [[SWOnMwiInfoParam alloc] initWithParam:param];
}

@end
