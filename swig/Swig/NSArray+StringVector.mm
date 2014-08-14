//
//  NSArray+StringVector.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "NSArray+StringVector.h"
#import "NSString+String.h"

#include <string>
#include <vector>

@implementation NSArray (StringVector)

+(NSArray *)arrayWithStringVector:(id)vector {
    
    std::vector<std::string> *stringVector = (std::vector<std::string> *)[vector pointerValue];
    
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i < stringVector->size(); ++i) {
        
        std::string string = stringVector->at(i);
        
        NSValue *stringValue = [NSValue valueWithPointer:&string];
        
        [temp addObject:[NSString stringFromCPPString:stringValue]];
    }
    
    return temp;
}

-(NSValue *)stringVector {
        
    std::vector<std::string> *stringVector =  new std::vector<std::string>;
    
    for (NSString *string in self) {
        
        std::string *cppString = (std::string *)[string.CPPString pointerValue];
        
        stringVector->push_back(*cppString);
    }
    
    return [NSValue valueWithPointer:stringVector];
}


@end
