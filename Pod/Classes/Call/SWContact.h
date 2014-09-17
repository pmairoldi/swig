//
//  SWContact.h
//  
//
//  Created by Pierre-Marc Airoldi on 2014-09-08.
//
//

#import <Foundation/Foundation.h>

@interface SWContact : NSObject <NSCopying, NSMutableCopying>

@property (nonatomic, readonly, strong) NSString *name;
@property (nonatomic, readonly, strong) NSString *address;

-(instancetype)initWithName:(NSString *)name address:(NSString *)address;

@end