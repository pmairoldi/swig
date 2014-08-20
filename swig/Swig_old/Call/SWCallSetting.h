//
//  SWCallSetting.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#include "pjsua2/account.hpp"
#include "pjsua2/call.hpp"
#endif

@interface SWCallSetting : NSObject

@property (nonatomic) NSUInteger flag;
@property (nonatomic) NSUInteger reqKeyframeMethod;
@property (nonatomic) NSUInteger audioCount;
@property (nonatomic) NSUInteger videoCount;

+(instancetype)defaultSettings;

#ifdef __cplusplus
-(pj::CallSetting)callSetting;
#endif

@end
