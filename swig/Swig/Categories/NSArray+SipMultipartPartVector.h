//
//  NSArray+SipMultipartPart.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#include <vector>
#include "pjsua2/siptypes.hpp"
#endif

@interface NSArray (SipMultipartPartVector)

#ifdef __cplusplus
+(NSArray *)arrayWithSipMultipartPartVector:(std::vector<pj::SipMultipartPart> *)vector;
-(std::vector<pj::SipMultipartPart> *)sipMultipartPartVector;
#endif

@end
