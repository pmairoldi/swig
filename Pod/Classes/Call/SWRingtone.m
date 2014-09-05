//
//  SWRingtone.m
//  
//
//  Created by Pierre-Marc Airoldi on 2014-09-04.
//
//

#import "SWRingtone.h"
#import <AVFoundation/AVAudioPlayer.h>

@interface SWRingtone ()

@property (nonatomic, strong) NSURL *fileURL;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation SWRingtone

-(instancetype)initWithFileAtPath:(NSURL *)path {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _fileURL = path;
    
    NSError *error;
    
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_fileURL error:&error];
    _audioPlayer.numberOfLoops = -1;
    
    if (error) {
        NSLog(@"%@", [error description]);
    }
    
    return self;
}

-(BOOL)isPlaying {
    return self.audioPlayer.isPlaying;
}

-(void)start {
 
    if (!self.audioPlayer.isPlaying) {
        [_audioPlayer prepareToPlay];
        [self.audioPlayer setCurrentTime:0];
        [self.audioPlayer play];
    }
}

-(void)stop {
    
    if (self.audioPlayer.isPlaying) {
        [self.audioPlayer stop];
    }
}

@end
