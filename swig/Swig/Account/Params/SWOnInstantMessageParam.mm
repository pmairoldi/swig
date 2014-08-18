//
//  SWOnInstantMessageParam.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWOnInstantMessageParam.h"
#import "NSString+String.h"

@implementation SWOnInstantMessageParam

-(instancetype)init {
    
    pj::OnInstantMessageParam param;
    
    return [[SWOnInstantMessageParam alloc] initWithParam:param];
}

-(instancetype)initWithParam:(pj::OnInstantMessageParam)param_ {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    pj::OnInstantMessageParam param = param_;
    _fromUri = [NSString stringWithCPPString:&param.fromUri];
    _toUri = [NSString stringWithCPPString:&param.toUri];
    _contactUri = [NSString stringWithCPPString:&param.contactUri];
    _contentType = [NSString stringWithCPPString:&param.contentType];
    _msgBody = [NSString stringWithCPPString:&param.msgBody];
    _rdata = [SWSipRxData sipRxDataFromSipRxData:param.rdata];
    
    return self;
}

+(instancetype)onParamFromParam:(pj::OnInstantMessageParam)param {
    
    return [[SWOnInstantMessageParam alloc] initWithParam:param];
}

@end