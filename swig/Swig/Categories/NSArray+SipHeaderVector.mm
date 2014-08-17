//
//  NSArray+SipHeaderVector.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-17.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "NSArray+SipHeaderVector.h"
#import "SWSipHeader.h"

@implementation NSArray (SipHeaderVector)

+(NSArray *)arrayWithSipHeaderVector:(std::vector<pj::SipHeader> *)vector {
    
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i < vector->size(); ++i) {
        
        pj::SipHeader value = vector->at(i);
        
        [temp addObject:[SWSipHeader sipHeaderFromSipHeader:value]];
    }
    
    return temp;
}

-(std::vector<pj::SipHeader> *)sipHeaderVector {
 
    std::vector<pj::SipHeader> *vector =  new std::vector<pj::SipHeader>;
    
    for (SWSipHeader *value in self) {
        
        vector->push_back(value.sipHeader);
    }
    
    return vector;
}

@end
