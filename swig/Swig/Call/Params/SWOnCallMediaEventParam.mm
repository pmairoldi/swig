//
//  SWOnCallMediaEventParam.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-19.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWOnCallMediaEventParam.h"

@implementation SWOnCallMediaEventParam

+(instancetype)onParamFromParam:(pj::OnCallMediaEventParam)param {

    return [SWOnCallMediaEventParam new];
}

@end
