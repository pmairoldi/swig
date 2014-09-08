
//
//  SWContact.m
//  
//
//  Created by Pierre-Marc Airoldi on 2014-09-08.
//
//

#import "SWContact.h"

@implementation SWContact

-(instancetype)init {
    
    return [self initWithName:nil address:nil];
}

-(instancetype)initWithName:(NSString *)name address:(NSString *)address {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _name = name;
    _address = address;
    
    return self;
}

@end
