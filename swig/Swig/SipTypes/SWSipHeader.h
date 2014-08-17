//
//  SipHeader.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-17.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#include "pjsua2/siptypes.hpp"
#endif

@interface SWSipHeader : NSObject

@property (nonatomic, strong) NSString *hName;
@property (nonatomic, strong) NSString *hValue;

#ifdef __cplusplus
+(instancetype)sipHeaderFromSipHeader:(pj::SipHeader)sipHeader;
-(pj::SipHeader)sipHeader;
#endif

@end
