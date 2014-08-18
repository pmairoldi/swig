//
//  SWCall.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWCall.h"
#import "SWAccount.h"
#import "SwigCall.h"
#import "NSError+Error.h"
#import "NSString+String.h"
#import "SWCallOpParam.h"
#import "SWEndpoint.h"

@interface SWCall ()

@property sw::Call *call;

@end

@implementation SWCall

-(instancetype)init {
    
    return nil;
}

-(instancetype)initWithCallId:(NSInteger)callId account:(SWAccount *)calledAccount {
    
    self = [super init];
    
    if (!self) {
        return self;
    }
    
    _call = new sw::Call(*calledAccount.swigAccount, callId);
    
    return self;
}

+(instancetype)callWithId:(NSInteger)callId account:(SWAccount *)calledAccount {
    
    return [[SWCall alloc] initWithCallId:callId account:calledAccount];
}

+(instancetype)callFromAccount:(SWAccount *)calledAccount {
    
    return [[SWCall alloc] initWithCallId:PJSUA_INVALID_ID account:calledAccount];
}

-(NSInteger)getId {
    
    return self.call->getId();
}

-(void)makeCall:(NSString *)destinationUri callOpParams:(SWCallOpParam *)param success:(void (^)())success failure:(void (^)(NSError *error))failure {
        
    if (!param) {
        param = [SWCallOpParam defaultSettings];
    }

    NSError *error;
    
    try {        
        self.call->makeCall(*[destinationUri CPPString], param.callOpParam);
    } catch(pj::Error& err) {
        error = [NSError errorWithError:&err];
    }
    
    if (error) {
        if (failure) {
            failure(error);
        }
    }
    
    else {
        if (success) {
            success();
        }
    }
}

-(void)answer:(SWCallOpParam *)param success:(void (^)())success failure:(void (^)(NSError *error))failure {

    if (!param) {
        param = [SWCallOpParam defaultSettings];
    }
    
    param.statusCode = PJSIP_SC_OK;
    
    NSError *error;
    
    try {
        self.call->answer(param.callOpParam);
        
        //TODO need to implement media 
        pj::AudioMediaPlayer player;
        pj::AudioMedia& play_med = pj::Endpoint::instance().audDevManager().getPlaybackDevMedia();
        pj::AudioMedia& cap_med = pj::Endpoint::instance().audDevManager().getCaptureDevMedia();
        
        pj::CallInfo ci = self.call->getInfo();
        pj::AudioMedia *aud_med = NULL;
        
        // Find out which media index is the audio
        for (unsigned i=0; i<ci.media.size(); ++i) {
            if (ci.media[i].type == PJMEDIA_TYPE_AUDIO) {
                aud_med = (pj::AudioMedia *)self.call->getMedia(i);
                break;
            }
        }
        
        if (aud_med) {
            // This will connect the sound device/mic to the call audio media
            cap_med.startTransmit(*aud_med);
            
            // And this will connect the call audio media to the sound device/speaker
            aud_med->startTransmit(play_med);
        }
        
    } catch(pj::Error& err) {
        error = [NSError errorWithError:&err];
    }
    
    if (error) {
        if (failure) {
            failure(error);
        }
    }
    
    else {
        if (success) {
            success();
        }
    }
}

@end
