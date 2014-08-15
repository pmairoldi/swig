//
//  SWm
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWLogConfiguration.h"
#import "NSString+String.h"

@interface SWLogConfiguration ()

@property (nonatomic) pj::LogConfig *config;

@end

@implementation SWLogConfiguration

-(instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _config = new pj::LogConfig;
    
    return self;
}

-(void)dealloc {
    
    delete _config;
}

-(pj::LogConfig *)config {
    
    return _config;
}

-(void)setMsgLogging:(NSUInteger)msgLogging {
    
    _config->msgLogging = msgLogging;
}

-(NSUInteger)msgLogging {

    return _config->msgLogging;
}

-(void)setLevel:(NSUInteger)level {
    
    _config->level = level;
}

-(NSUInteger)level {
    
    return _config->level;
}

-(void)setConsoleLevel:(NSUInteger)consoleLevel {
    
    _config->consoleLevel = consoleLevel;
}

-(NSUInteger)consoleLevel {
    
    return _config->consoleLevel;
}

-(void)setDecor:(NSUInteger)decor {
    
    _config->decor = decor;
}

-(NSUInteger)decor {
    
    return _config->decor;
}

-(void)setFilename:(NSString *)filename {
    
    _config->filename = *[filename CPPString];
}

-(NSString *)filename {
    
    return [NSString stringFromCPPString:&_config->filename];
}

-(void)setFileFlags:(NSUInteger)fileFlags {
    
    _config->fileFlags = fileFlags;
}

-(NSUInteger)fileFlags {
    
    return _config->fileFlags;
}

-(void)setLogWriter:(SWLogWriter *)logWriter {
    //TODO::implement
}

-(SWLogWriter *)logWriter {
 
    //TODO::implement
    return nil;
}

@end
