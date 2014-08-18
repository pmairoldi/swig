//
//  NSArray+SipMultipartPart.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "NSArray+SipMultipartPartVector.h"
#import "SWSipMultipartPart.h"

@implementation NSArray (SipMultipartPartVector)

+(NSArray *)arrayWithSipMultipartPartVector:(std::vector<pj::SipMultipartPart> *)vector {
    
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i < vector->size(); ++i) {
        
        pj::SipMultipartPart value = vector->at(i);
        
        [temp addObject:[SWSipMultipartPart sipMultipartPartFromSipMultipartPart:value]];
    }
    
    return temp;
}

-(std::vector<pj::SipMultipartPart> *)sipMultipartPartVector {

    std::vector<pj::SipMultipartPart> *vector =  new std::vector<pj::SipMultipartPart>;
    
    for (SWSipMultipartPart *value in self) {
        
        vector->push_back(value.sipMultipartPart);
    }
    
    return vector;
}

@end
