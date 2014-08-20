//
//  NSArray+StringVector.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "NSArray+StringVector.h"
#import "NSString+String.h"

@implementation NSArray (StringVector)

+(NSArray *)arrayWithStringVector:(std::vector<std::string> *)vector {
    
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i < vector->size(); ++i) {
        
        std::string string = vector->at(i);
        
        [temp addObject:[NSString stringWithCPPString:&string]];
    }
    
    return temp;
}

-(std::vector<std::string> *)stringVector {
        
    std::vector<std::string> *vector =  new std::vector<std::string>;
    
    for (NSString *string in self) {
                
        vector->push_back(*string.CPPString);
    }
    
    return vector;
}

@end
