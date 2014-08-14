//
//  SWUserAgentConfiguration.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWUserAgentConfiguration : NSObject

@property (nonatomic) NSUInteger maxCalls;
@property (nonatomic) NSUInteger threadCnt;
@property (nonatomic) BOOL mainThreadOnly;
@property (nonatomic, strong) NSArray *nameserver;
@property (nonatomic, strong) NSString *userAgent;
@property (nonatomic, strong) NSArray *stunServer;
@property (nonatomic) BOOL stunIgnoreFailure;
@property (nonatomic) NSInteger natTypeInSdp;
@property (nonatomic) BOOL mwiUnsolicitedEnabled;

@end
