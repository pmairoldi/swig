//
//  SWAuthCredInfo.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-17.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWAuthCredInfo.h"
#import "NSString+String.h"

@implementation SWAuthCredInfo

-(instancetype)init {
    
    pj::AuthCredInfo authCredInfo;
    
    return [self initWithAuthCredInfo:authCredInfo];
}

-(instancetype)initWithAuthCredInfo:(pj::AuthCredInfo)authCredInfo {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _scheme = [NSString stringWithCPPString:&authCredInfo.scheme];
    _realm = [NSString stringWithCPPString:&authCredInfo.realm];
    _username = [NSString stringWithCPPString:&authCredInfo.username];
    _dataType = authCredInfo.dataType;
    _data = [NSString stringWithCPPString:&authCredInfo.data];
    _akaK = [NSString stringWithCPPString:&authCredInfo.akaK];
    _akaOp = [NSString stringWithCPPString:&authCredInfo.akaOp];
    _akaAmf = [NSString stringWithCPPString:&authCredInfo.akaAmf];

    return self;
}

+(instancetype)authCredInfoFromAuthCredInfo:(pj::AuthCredInfo)authCredInfo {
    
    return [[SWAuthCredInfo alloc] initWithAuthCredInfo:authCredInfo];
}

-(pj::AuthCredInfo)authCredInfo {
    
    pj::AuthCredInfo authCredInfo;
    authCredInfo.scheme = *[self.scheme CPPString];
    authCredInfo.realm = *[self.realm CPPString];
    authCredInfo.username = *[self.username CPPString];
    authCredInfo.dataType = self.dataType;
    authCredInfo.data = *[self.data CPPString];
    authCredInfo.akaK = *[self.akaK CPPString];
    authCredInfo.akaOp = *[self.akaOp CPPString];
    authCredInfo.akaAmf = *[self.akaAmf CPPString];
    
    return authCredInfo;
}

@end
