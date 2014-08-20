//
//  NSArray+SipHeaderVector.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-17.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#include <vector>
#include "pjsua2/siptypes.hpp"
#endif

@interface NSArray (SipHeaderVector)

#ifdef __cplusplus
+(NSArray *)arrayWithSipHeaderVector:(std::vector<pj::SipHeader> *)vector;
-(std::vector<pj::SipHeader> *)sipHeaderVector;
#endif

@end
