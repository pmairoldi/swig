//
//  SWAuthCredInfo.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-17.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#include "pjsua2/siptypes.hpp"
#endif

@interface SWAuthCredInfo : NSObject

@property (nonatomic, strong) NSString *scheme;
@property (nonatomic, strong) NSString *realm;
@property (nonatomic, strong) NSString *username;
@property (nonatomic) NSInteger dataType;
@property (nonatomic, strong) NSString *data; //TODO change to password
@property (nonatomic, strong) NSString *akaK;
@property (nonatomic, strong) NSString *akaOp;
@property (nonatomic, strong) NSString *akaAmf;

#ifdef __cplusplus
+(instancetype)authCredInfoFromAuthCredInfo:(pj::AuthCredInfo)authCredInfo;
-(pj::AuthCredInfo)authCredInfo;
#endif

@end
