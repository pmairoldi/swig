//
//  NSArray+AuthCredInfoVector.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-17.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "NSArray+AuthCredInfoVector.h"
#import "SWAuthCredInfo.h"

@implementation NSArray (AuthCredInfoVector)

+(NSArray *)arrayWithAuthCredInfoVector:(std::vector<pj::AuthCredInfo> *)vector {
    
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i < vector->size(); ++i) {
        
        pj::AuthCredInfo value = vector->at(i);
        
        [temp addObject:[SWAuthCredInfo authCredInfoFromAuthCredInfo:value]];
    }
    
    return temp;
}

-(std::vector<pj::AuthCredInfo> *)authCredInfoVector {
    
    std::vector<pj::AuthCredInfo> *vector =  new std::vector<pj::AuthCredInfo>;
    
    for (SWAuthCredInfo *value in self) {
        
        vector->push_back(value.authCredInfo);
    }
    
    return vector;
}


@end
