//
//  NSArray+IntVector.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#include <vector>
#endif

@interface NSArray (IntVector)

#ifdef __cplusplus
+(NSArray *)arrayWithIntVector:(std::vector<int> *)vector;
-(std::vector<int> *)intVector;
#endif

@end