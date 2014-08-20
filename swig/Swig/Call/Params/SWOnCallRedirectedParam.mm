//
//  SWOnCallRedirectedParam.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-19.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWOnCallRedirectedParam.h"

@implementation SWOnCallRedirectedParam

+(instancetype)onParamFromParam:(pj::OnCallRedirectedParam)param {
    
    return [SWOnCallRedirectedParam new];
}

@end
