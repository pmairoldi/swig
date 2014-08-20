//
//  NSArray+AuthCredInfoVector.h
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

@interface NSArray (AuthCredInfoVector)

#ifdef __cplusplus
+(NSArray *)arrayWithAuthCredInfoVector:(std::vector<pj::AuthCredInfo> *)vector;
-(std::vector<pj::AuthCredInfo> *)authCredInfoVector;
#endif

@end
