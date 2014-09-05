//
//  SWRingtone.h
//  
//
//  Created by Pierre-Marc Airoldi on 2014-09-04.
//
//

#import <Foundation/Foundation.h>
#import "SWPlayableProtocol.h"

@interface SWRingtone : NSObject <SWPlayableProtocol>

@property (nonatomic, readonly) BOOL isPlaying;

-(instancetype)initWithFileAtPath:(NSURL *)path;

@end
