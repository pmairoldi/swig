//
//  SipRxData.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#include "pjsua2/siptypes.hpp"
#endif

@interface SWSipRxData : NSObject

@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSString *wholeMsg;
@property (nonatomic, strong) NSString *srcAddress;
@property (nonatomic, strong) NSValue *pjRxData; //void pointer to data

#ifdef __cplusplus
+(instancetype)sipRxDataFromSipRxData:(pj::SipRxData)sipRxData;
-(pj::SipRxData)sipRxData;
#endif

@end
