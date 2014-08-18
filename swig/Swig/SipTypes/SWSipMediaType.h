//
//  SWSipMediaType.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#include "pjsua2/siptypes.hpp"
#endif

@interface SWSipMediaType : NSObject

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *subType;

#ifdef __cplusplus
+(instancetype)sipMediaTypeFromSipMediaType:(pj::SipMediaType)sipMediaType;
-(pj::SipMediaType)sipMediaType;
#endif

@end
