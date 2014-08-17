//
//  SWUserAgent.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWAccount.h"

@interface SWUserAgent : NSObject

+(SWUserAgent*)sharedInstance;

-(void)addAccount:(SWAccount *)account;
-(SWAccount *)accountFromId:(NSInteger)accountId;

@end
