//
//  SWOnIncomingSubscribeParam.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWOnIncomingSubscribeParam.h"
#import "NSString+String.h"

@implementation SWOnIncomingSubscribeParam

-(instancetype)init {
    
    pj::OnIncomingSubscribeParam param;
    
    return [[SWOnIncomingSubscribeParam alloc] initWithParam:param];
}

-(instancetype)initWithParam:(pj::OnIncomingSubscribeParam)param_ {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    pj::OnIncomingSubscribeParam param = param_;
    _srvPres = [NSValue valueWithPointer:param.srvPres];
    _fromUri = [NSString stringWithCPPString:&param.fromUri];
    _rdata = [SWSipRxData sipRxDataFromSipRxData:param.rdata];
    _code = param.code;
    _reason = [NSString stringWithCPPString:&param.reason];
    _txOption = [SWSipTxOption sipTxOptionFromSipTxOption:param.txOption];
    
    return self;
}

+(instancetype)onParamFromParam:(pj::OnIncomingSubscribeParam)param {
    
    return [[SWOnIncomingSubscribeParam alloc] initWithParam:param];
}

@end
