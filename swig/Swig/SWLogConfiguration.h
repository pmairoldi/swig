//
//  SWLogConfiguration.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#include "pjsua2/endpoint.hpp"
#endif
#import "SWLogWriter.h"

@interface SWLogConfiguration : NSObject

//getters
#ifdef __cplusplus
-(pj::LogConfig *)config;
#endif
-(NSUInteger)msgLogging;
-(NSUInteger)level;
-(NSUInteger)consoleLevel;
-(NSUInteger)decor;
-(NSString *)filename;
-(NSUInteger)fileFlags;
-(SWLogWriter *)logWriter;

//setters
-(void)setMsgLogging:(NSUInteger)msgLogging;
-(void)setLevel:(NSUInteger)level;
-(void)setConsoleLevel:(NSUInteger)consoleLevel;
-(void)setDecor:(NSUInteger)decor;
-(void)setFilename:(NSString *)filename;
-(void)setFileFlags:(NSUInteger)fileFlags;
-(void)setLogWriter:(SWLogWriter *)logWriter;

@end
