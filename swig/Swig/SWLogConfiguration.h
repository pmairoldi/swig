//
//  SWLogConfiguration.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWLogConfiguration : NSObject

@property (nonatomic) NSUInteger msgLogging;
@property (nonatomic) NSUInteger level;
@property (nonatomic) NSUInteger consoleLevel;
@property (nonatomic) NSUInteger decor;
@property (nonatomic, strong) NSString *filename;
@property (nonatomic) NSUInteger fileFlags;
//LogWriter omitted since it is not needed

@end
