//
//  SWRingtone.h
//  
//
//  Created by Pierre-Marc Airoldi on 2014-09-04.
//
//

#import <Foundation/Foundation.h>
#import "SWPlayableProtocol.h"
#import <AVFoundation/AVAudioPlayer.h>

@interface SWRingtone : NSObject <SWPlayableProtocol>

@property (nonatomic, readonly) BOOL isPlaying;
@property (nonatomic) float volume;
@property (nonatomic, strong, readonly) NSURL *fileURL;

-(instancetype)initWithFileAtPath:(NSURL *)path;

@end
