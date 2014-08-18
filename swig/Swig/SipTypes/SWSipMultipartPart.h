//
//  SWSipMultipartPart.h
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

@interface SWSipMultipartPart : NSObject

@property (nonatomic, strong) NSArray *headers;
@property (nonatomic, strong) SWSipMediaType *contentType;
@property (nonatomic, strong) NSString *body;

#ifdef __cplusplus
+(instancetype)sipMultipartPartFromSipMultipartPart:(pj::SipMultipartPart)sipMultipartPart;
-(pj::SipMultipartPart)sipMultipartPart;
#endif

@end
