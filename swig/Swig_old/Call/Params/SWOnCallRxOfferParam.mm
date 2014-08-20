//
//  SWOnCallRxOfferParam.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-19.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWOnCallRxOfferParam.h"

@implementation SWOnCallRxOfferParam

+(instancetype)onParamFromParam:(pj::OnCallRxOfferParam)param {

    return [SWOnCallRxOfferParam new];
}

@end
