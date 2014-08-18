//
//  SWOnRegStartedParam.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWOnRegStartedParam.h"

@implementation SWOnRegStartedParam

-(instancetype)init {
    
    pj::OnRegStartedParam param;
    
    return [[SWOnRegStartedParam alloc] initWithParam:param];
}

-(instancetype)initWithParam:(pj::OnRegStartedParam)param_ {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    pj::OnRegStartedParam param = param_;
    _renew = param.renew;
    
    return self;
}

+(instancetype)onParamFromParam:(pj::OnRegStartedParam)param {
    
    return [[SWOnRegStartedParam alloc] initWithParam:param];
}

@end
