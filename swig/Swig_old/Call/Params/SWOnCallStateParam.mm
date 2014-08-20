//
//  SWOnCallStateParam.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-19.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWOnCallStateParam.h"

@implementation SWOnCallStateParam

+(instancetype)onParamFromParam:(pj::OnCallStateParam)param {
    
    return [SWOnCallStateParam new];
}

@end
