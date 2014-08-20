//
//  SWOnCallTransferStatusParam.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-19.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWOnCallTransferStatusParam.h"

@implementation SWOnCallTransferStatusParam

+(instancetype)onParamFromParam:(pj::OnCallTransferStatusParam)param {
    
    return [SWOnCallTransferStatusParam new];
}

@end
