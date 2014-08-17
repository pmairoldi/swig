//
//  SWAccountSipConfiguration.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#include <pjsua2/account.hpp>
#endif

@interface SWAccountSipConfiguration : NSObject

@property (nonatomic, strong) NSArray *authCreds;
@property (nonatomic, strong) NSArray *proxies;
@property (nonatomic, strong) NSString *contactForced;
@property (nonatomic, strong) NSString *contactParams;
@property (nonatomic, strong) NSString *contactUriParams;
@property (nonatomic) BOOL authInitialEmpty;
@property (nonatomic, strong) NSString *authInitialAlgorithm;
@property (nonatomic) NSInteger transportId;

#ifdef __cplusplus
-(pj::AccountSipConfig)config;
#endif

@end
