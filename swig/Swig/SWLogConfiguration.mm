//
//  SWLogConfiguration.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWLogConfiguration.h"
#import "PJSUA2.h"

@implementation SWLogConfiguration

-(instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    LogConfig config;
    
    _msgLogging = config.msgLogging;
    _level = config.level;
    _consoleLevel = config.consoleLevel;
    _decor = config.decor;
    _filename = [NSString stringFromCPPString:[NSValue valueWithPointer:&config.filename]];
    _fileFlags = config.fileFlags;
    
    return self;
}

@end
