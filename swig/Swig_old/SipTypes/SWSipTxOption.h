//
//  SWSipTxOption.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SWSipMediaType.h"
#ifdef __cplusplus
#include "pjsua2/siptypes.hpp"
#endif

@interface SWSipTxOption : NSObject

@property (nonatomic, strong) NSString *targetUri;
@property (nonatomic, strong) NSArray *headers;
@property (nonatomic, strong) NSString *contentType;
@property (nonatomic, strong) NSString *msgBody;
@property (nonatomic, strong) SWSipMediaType *multipartContentType;
@property (nonatomic, strong) NSArray *multipartParts;

#ifdef __cplusplus
+(instancetype)sipTxOptionFromSipTxOption:(pj::SipTxOption)sipTxOption;
-(pj::SipTxOption)sipTxOption;
#endif

@end