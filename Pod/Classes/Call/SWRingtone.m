//
//  SWRingtone.m
//
//
//  Created by Pierre-Marc Airoldi on 2014-09-04.
//
//

#import "SWRingtone.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "SharkfoodMuteSwitchDetector.h"
#import <UIKit/UIKit.h>
#import <libextobjc/extobjc.h>
#import "Logger.h"

#define kVibrateDuration 2.0

@interface SWRingtone ()

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) NSTimer *virbateTimer;

@end

@implementation SWRingtone

-(instancetype)init {
    
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Ringtone" ofType:@"aif"]];
    
    return [self initWithFileAtPath:fileURL];
}

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
        DDLogDebug(@"%@", [error description]);
    }
    
    self.virbateTimer = [NSTimer timerWithTimeInterval:kVibrateDuration target:self selector:@selector(vibrate) userInfo:nil repeats:YES];

    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(handleEnteredBackground:) name: UIApplicationDidEnterBackgroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(handleEnteredForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];

    @weakify(self);
    [SharkfoodMuteSwitchDetector shared].silentNotify = ^(BOOL silent){
        
        @strongify(self);
        
        if (silent) {
            
            self.volume = 0.0;
        }
        
        else {
            
            self.volume = 1.0;
        }
    };
    
    return self;
}

-(void)dealloc {
    
    [_audioPlayer stop];
    _audioPlayer = nil;
    
    [_virbateTimer invalidate];
    _virbateTimer = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}

-(BOOL)isPlaying {
    return self.audioPlayer.isPlaying;
}

-(void)start {
    
    if (!self.audioPlayer.isPlaying) {
        
        [self.audioPlayer prepareToPlay];
        
        [self configureAudioSession];

        [self.audioPlayer play];
        
        [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
        [[NSRunLoop mainRunLoop] addTimer:self.virbateTimer forMode:NSRunLoopCommonModes];
//        [self.virbateTimer s];
    }
}

-(void)stop {
    
    if (self.audioPlayer.isPlaying) {
        [self.audioPlayer stop];
        [self.virbateTimer invalidate];
    }
    
    [self.audioPlayer setCurrentTime:0];
}

-(void)setVolume:(float)volume {
    
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
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

-(void)configureAudioSession {
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    NSError *setCategoryError;
    
    if (![audioSession setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionDuckOthers|AVAudioSessionCategoryOptionAllowBluetooth error:&setCategoryError]) {
        
    }
    
    NSError *overrideError;
    
    if ([audioSession overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:&overrideError]) {
        
    }
    
    NSError *activationError;
    
    if (![audioSession setActive:YES error:&activationError]) {
        
    }

}

#pragma Notification Methods

-(void)handleEnteredBackground:(NSNotification *)notification {
    
    self.volume = 0.0;
    
}

-(void)handleEnteredForeground:(NSNotification *)notification {
    
    if ([SharkfoodMuteSwitchDetector shared].isMute) {
        self.volume = 0.0;
    }
    
    else {
        self.volume = 1.0;
    }
}

@end
