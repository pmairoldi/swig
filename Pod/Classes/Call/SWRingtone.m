//
//  SWRingtone.m
//
//
//  Created by Pierre-Marc Airoldi on 2014-09-04.
//
//

#import "SWRingtone.h"
#import <AudioToolbox/AudioToolbox.h>

@interface SWRingtone ()

@property (nonatomic, strong) NSURL *fileURL;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) NSTimer *virbateTimer;

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
    
    _virbateTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(vibrate) userInfo:nil repeats:YES];
    
    return self;
}

-(void)dealloc {
    
    [_virbateTimer invalidate];
    _virbateTimer = nil;
}

-(BOOL)isPlaying {
    return self.audioPlayer.isPlaying;
}

-(void)start {
    
    if (!self.audioPlayer.isPlaying) {
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
        
        [self.virbateTimer fire];
        [[NSRunLoop currentRunLoop] addTimer:self.virbateTimer forMode:NSRunLoopCommonModes];
    }
}

-(void)stop {
    
    if (self.audioPlayer.isPlaying) {
        [self.audioPlayer stop];
        [self.virbateTimer invalidate];
    }
    
    [self.audioPlayer setCurrentTime:0];
}

-(void)setVolume:(CGFloat)volume {
    
    [self willChangeValueForKey:@"volume"];
    
    if (volume < 0.0) {
        _volume = 0.0;
    }
    
    else if (volume > 0.0) {
        _volume = 1.0;
    }
    
    else {
        _volume = volume;
    }
    
    [self didChangeValueForKey:@"volume"];
 
    self.audioPlayer.volume = _volume;
}

-(void)vibrate {
    
    NSLog(@"\n\n\n\nvibrate\n\n\n\n");
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
