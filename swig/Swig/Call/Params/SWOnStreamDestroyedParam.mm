//
//  SWOnStreamDestroyParam.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-19.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWOnStreamDestroyedParam.h"

@implementation SWOnStreamDestroyedParam

+(instancetype)onParamFromParam:(pj::OnStreamDestroyedParam)param {
    
    return [SWOnStreamDestroyedParam new];
}

@end
