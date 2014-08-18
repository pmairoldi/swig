//
//  SWUserAgent.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SWAccount;

@interface SWUserAgent : NSObject

+(SWUserAgent*)sharedInstance;

-(void)beginWithTransportConfigurations:(NSArray *)transportConfigurations;
-(void)addAccount:(SWAccount *)account;
-(SWAccount *)accountWithId:(NSInteger)accountId;

@end
