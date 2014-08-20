//
//  SWOnCallTransferRequestParam.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-19.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWOnCallTransferRequestParam.h"

@implementation SWOnCallTransferRequestParam

+(instancetype)onParamFromParam:(pj::OnCallTransferRequestParam)param {
    
    return [SWOnCallTransferRequestParam new];
}

@end
