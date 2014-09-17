//
//  SWMutableCall.h
//  
//
//  Created by Pierre-Marc Airoldi on 2014-09-17.
//
//

#import "SWCall.h"
#import "SWMutableContact.h"

@interface SWMutableCall : SWCall

@property (nonatomic, strong) SWMutableContact *contact;
@property (nonatomic) BOOL inbound;
@property (nonatomic) BOOL missed;
@property (nonatomic) NSDate *date;
@property (nonatomic) NSTimeInterval duration; //TODO: update with timer

@end
