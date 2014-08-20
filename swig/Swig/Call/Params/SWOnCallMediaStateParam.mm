//
//  SWOnCallMediaStateParam.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-19.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWOnCallMediaStateParam.h"

@implementation SWOnCallMediaStateParam

+(instancetype)onParamFromParam:(pj::OnCallMediaStateParam)param {
    
    return [SWOnCallMediaStateParam new];
}

@end
