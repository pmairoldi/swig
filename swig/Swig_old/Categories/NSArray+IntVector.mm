//
//  NSArray+IntVector.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "NSArray+IntVector.h"

@implementation NSArray (IntVector)

+(NSArray *)arrayWithIntVector:(std::vector<int> *)vector {
    
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i < vector->size(); ++i) {
        
        int value = vector->at(i);
        
        [temp addObject:@(value)];
    }
    
    return temp;
}

-(std::vector<int> *)intVector {
    
    std::vector<int> *vector =  new std::vector<int>;
    
    for (NSNumber *value in self) {
        
        vector->push_back([value intValue]);
    }
    
    return vector;
}

@end
