//
//  NSArray+StringVector.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#include <string>
#include <vector>
#endif

@interface NSArray (StringVector)

#ifdef __cplusplus
+(NSArray *)arrayWithStringVector:(std::vector<std::string> *)vector;
-(std::vector<std::string> *)stringVector;
#endif

@end
