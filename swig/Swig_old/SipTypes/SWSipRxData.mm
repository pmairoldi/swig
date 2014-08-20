//
//  SipRxData.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWSipRxData.h"
#import "NSString+String.h"

@implementation SWSipRxData

-(instancetype)init {
    
    pj::SipRxData sipRxData;
    
    return [self initWithSipRxData:sipRxData];
}

-(instancetype)initWithSipRxData:(pj::SipRxData)sipRxData_ {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    pj::SipRxData sipRxData = sipRxData_;
    _info = [NSString stringWithCPPString:&sipRxData.info];
    _wholeMsg = [NSString stringWithCPPString:&sipRxData.wholeMsg];
    _srcAddress = [NSString stringWithCPPString:&sipRxData.srcAddress];
    _pjRxData = [NSValue valueWithPointer:sipRxData.pjRxData];
    
    return self;
}

+(instancetype)sipRxDataFromSipRxData:(pj::SipRxData)sipRxData {
    
    return [[SWSipRxData alloc] initWithSipRxData:sipRxData];
}

-(pj::SipRxData)sipRxData {
    
    pj::SipRxData sipRxData;
    sipRxData.info = *[self.info CPPString];
    sipRxData.wholeMsg = *[self.wholeMsg CPPString];
    sipRxData.srcAddress = *[self.srcAddress CPPString];
    sipRxData.pjRxData = [self.pjRxData pointerValue];
    
    return sipRxData;
}

@end
