//
//  SWCallOpParams.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWCallOpParam.h"
#import "NSString+String.h"

@implementation SWCallOpParam

-(instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    pj::CallOpParam callOpParam(true);
    _opt = [SWCallSetting defaultSettings];
    _statusCode = callOpParam.statusCode;
    _reason = [NSString stringWithCPPString:&callOpParam.reason];
    _options = callOpParam.options;
    _txOption = [SWSipTxOption sipTxOptionFromSipTxOption:callOpParam.txOption];
    
    return self;
}

+(instancetype)defaultSettings {

    return [[SWCallOpParam alloc] init];
}

-(pj::CallOpParam)callOpParam {
    
    pj::CallOpParam callOpParam(true);
    callOpParam.opt = self.opt.callSetting;
    callOpParam.statusCode = self.statusCode;
    callOpParam.reason = *[self.reason CPPString];
    callOpParam.options = self.options;
    callOpParam.txOption = self.txOption.sipTxOption;
    
    return callOpParam;
}

@end
