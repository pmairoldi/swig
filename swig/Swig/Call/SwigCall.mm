//
//  SwigCall.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-17.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#include "SwigCall.h"
#import "SWUserAgent.h"
#import "SWAccount.h"
#import "SWCall.h"
#include "pjsua2/endpoint.hpp"

void sw::Call::onCallState(pj::OnCallStateParam &prm) {
    
    SWUserAgent *userAgent = [SWUserAgent sharedInstance];
    pj::CallInfo callInfo = getInfo();
    SWAccount *account = [userAgent accountWithId:callInfo.accId];
    SWCall *call = [account callWithId:getId()];
    
    //TODO: add params
    [call onCallState:nil];
}

void sw::Call::onCallTsxState(pj::OnCallTsxStateParam &prm) {
    
    SWUserAgent *userAgent = [SWUserAgent sharedInstance];
    pj::CallInfo callInfo = getInfo();
    SWAccount *account = [userAgent accountWithId:callInfo.accId];
    SWCall *call = [account callWithId:getId()];
    
    //TODO: add params
    [call onCallTsxState:nil];
}

void sw::Call::onCallMediaState(pj::OnCallMediaStateParam &prm) {
 
    //TODO need to implement media
    pj::AudioMediaPlayer player;
    pj::AudioMedia& play_med = pj::Endpoint::instance().audDevManager().getPlaybackDevMedia();
    pj::AudioMedia& cap_med = pj::Endpoint::instance().audDevManager().getCaptureDevMedia();
    
    pj::CallInfo ci = getInfo();
    pj::AudioMedia *aud_med = NULL;
    
    // Find out which media index is the audio
    for (unsigned i=0; i<ci.media.size(); ++i) {
        if (ci.media[i].type == PJMEDIA_TYPE_AUDIO) {
            aud_med = (pj::AudioMedia *)getMedia(i);
            break;
        }
    }
    
    if (aud_med) {
        // This will connect the sound device/mic to the call audio media
        cap_med.startTransmit(*aud_med);
        
        // And this will connect the call audio media to the sound device/speaker
        aud_med->startTransmit(play_med);
    }
    
    SWUserAgent *userAgent = [SWUserAgent sharedInstance];
    pj::CallInfo callInfo = getInfo();
    SWAccount *account = [userAgent accountWithId:callInfo.accId];
    SWCall *call = [account callWithId:getId()];
    
    //TODO: add params
    [call onCallMediaState:nil];
}

void sw::Call::onCallSdpCreated(pj::OnCallSdpCreatedParam &prm) {
    
    SWUserAgent *userAgent = [SWUserAgent sharedInstance];
    pj::CallInfo callInfo = getInfo();
    SWAccount *account = [userAgent accountWithId:callInfo.accId];
    SWCall *call = [account callWithId:getId()];
    
    //TODO: add params
    [call onCallSdpCreated:nil];
}

void sw::Call::onStreamCreated(pj::OnStreamCreatedParam &prm) {
    
    SWUserAgent *userAgent = [SWUserAgent sharedInstance];
    pj::CallInfo callInfo = getInfo();
    SWAccount *account = [userAgent accountWithId:callInfo.accId];
    SWCall *call = [account callWithId:getId()];
    
    //TODO: add params
    [call onStreamCreated:nil];
}

void sw::Call::onStreamDestroyed(pj::OnStreamDestroyedParam &prm) {
    
    SWUserAgent *userAgent = [SWUserAgent sharedInstance];
    pj::CallInfo callInfo = getInfo();
    SWAccount *account = [userAgent accountWithId:callInfo.accId];
    SWCall *call = [account callWithId:getId()];
    
    //TODO: add params
    [call onStreamDestroyed:nil];
}

void sw::Call::onDtmfDigit(pj::OnDtmfDigitParam &prm) {
    
    SWUserAgent *userAgent = [SWUserAgent sharedInstance];
    pj::CallInfo callInfo = getInfo();
    SWAccount *account = [userAgent accountWithId:callInfo.accId];
    SWCall *call = [account callWithId:getId()];
    
    //TODO: add params
    [call onDtmfDigit:nil];
}

void sw::Call::onCallTransferRequest(pj::OnCallTransferRequestParam &prm) {
    
    SWUserAgent *userAgent = [SWUserAgent sharedInstance];
    pj::CallInfo callInfo = getInfo();
    SWAccount *account = [userAgent accountWithId:callInfo.accId];
    SWCall *call = [account callWithId:getId()];
    
    //TODO: add params
    [call onCallTransferRequest:nil];
}

void sw::Call::onCallTransferStatus(pj::OnCallTransferStatusParam &prm) {
    
    SWUserAgent *userAgent = [SWUserAgent sharedInstance];
    pj::CallInfo callInfo = getInfo();
    SWAccount *account = [userAgent accountWithId:callInfo.accId];
    SWCall *call = [account callWithId:getId()];
    
    //TODO: add params
    [call onCallTransferStatus:nil];
}

void sw::Call::onCallReplaceRequest(pj::OnCallReplaceRequestParam &prm) {
    
    SWUserAgent *userAgent = [SWUserAgent sharedInstance];
    pj::CallInfo callInfo = getInfo();
    SWAccount *account = [userAgent accountWithId:callInfo.accId];
    SWCall *call = [account callWithId:getId()];
    
    //TODO: add params
    [call onCallReplaceRequest:nil];
}

void sw::Call::onCallReplaced(pj::OnCallReplacedParam &prm) {
    
    SWUserAgent *userAgent = [SWUserAgent sharedInstance];
    pj::CallInfo callInfo = getInfo();
    SWAccount *account = [userAgent accountWithId:callInfo.accId];
    SWCall *call = [account callWithId:getId()];
    
    //TODO: add params
    [call onCallReplaced:nil];
}

void sw::Call::onCallRxOffer(pj::OnCallRxOfferParam &prm) {
    
    SWUserAgent *userAgent = [SWUserAgent sharedInstance];
    pj::CallInfo callInfo = getInfo();
    SWAccount *account = [userAgent accountWithId:callInfo.accId];
    SWCall *call = [account callWithId:getId()];
    
    //TODO: add params
    [call onCallRxOffer:nil];
}

void sw::Call::onInstantMessage(pj::OnInstantMessageParam &prm) {
    
    SWUserAgent *userAgent = [SWUserAgent sharedInstance];
    pj::CallInfo callInfo = getInfo();
    SWAccount *account = [userAgent accountWithId:callInfo.accId];
    SWCall *call = [account callWithId:getId()];
    
    //TODO: add params
    [call onInstantMessage:nil];
}

void sw::Call::onInstantMessageStatus(pj::OnInstantMessageStatusParam &prm) {
    
    SWUserAgent *userAgent = [SWUserAgent sharedInstance];
    pj::CallInfo callInfo = getInfo();
    SWAccount *account = [userAgent accountWithId:callInfo.accId];
    SWCall *call = [account callWithId:getId()];
    
    //TODO: add params
    [call onInstantMessageStatus:nil];
}

void sw::Call::onTypingIndication(pj::OnTypingIndicationParam &prm) {
    
    SWUserAgent *userAgent = [SWUserAgent sharedInstance];
    pj::CallInfo callInfo = getInfo();
    SWAccount *account = [userAgent accountWithId:callInfo.accId];
    SWCall *call = [account callWithId:getId()];
    
    //TODO: add params
    [call onTypingIndication:nil];
}

pjsip_redirect_op sw::Call::onCallRedirected(pj::OnCallRedirectedParam &prm) {
    
    SWUserAgent *userAgent = [SWUserAgent sharedInstance];
    pj::CallInfo callInfo = getInfo();
    SWAccount *account = [userAgent accountWithId:callInfo.accId];
    SWCall *call = [account callWithId:getId()];
    
    //TODO: add params
    return [call onCallRedirected:nil];
}

void sw::Call::onCallMediaTransportState(pj::OnCallMediaTransportStateParam &prm) {
    
    SWUserAgent *userAgent = [SWUserAgent sharedInstance];
    pj::CallInfo callInfo = getInfo();
    SWAccount *account = [userAgent accountWithId:callInfo.accId];
    SWCall *call = [account callWithId:getId()];
    
    //TODO: add params
    [call onCallMediaTransportState:nil];
}

void sw::Call::onCallMediaEvent(pj::OnCallMediaEventParam &prm) {
    
    SWUserAgent *userAgent = [SWUserAgent sharedInstance];
    pj::CallInfo callInfo = getInfo();
    SWAccount *account = [userAgent accountWithId:callInfo.accId];
    SWCall *call = [account callWithId:getId()];
    
    //TODO: add params
    [call onCallMediaEvent:nil];
}

void sw::Call::onCreateMediaTransport(pj::OnCreateMediaTransportParam &prm) {
 
    SWUserAgent *userAgent = [SWUserAgent sharedInstance];
    pj::CallInfo callInfo = getInfo();
    SWAccount *account = [userAgent accountWithId:callInfo.accId];
    SWCall *call = [account callWithId:getId()];
    
    //TODO: add params
    [call onCreateMediaTransport:nil];
}