//
//  SWAccount.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWAccountConfiguration.h"

@interface SWAccount : NSObject

-(instancetype)initWithAccountConfiguration:(SWAccountConfiguration *)accountConfiguration;

+(SWAccount *)accountForId:(NSInteger)accountId;

@end
