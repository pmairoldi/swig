//
//  SWUriFormatter.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-21.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

//TODO actually make it an nsformatter

@class SWAccount;

@interface SWUriFormatter : NSFormatter

+(NSString *)sipUri:(NSString *)uri;
+(NSString *)sipUri:(NSString *)uri fromAccount:(SWAccount *)account;
+(NSString *)sipUri:(NSString *)uri withDisplayName:(NSString *)displayName;

@end
