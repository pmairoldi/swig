//
//  SWUriFormatter.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-21.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWUriFormatter : NSFormatter

+(NSString *)sipUri:(NSString *)uri;

@end
