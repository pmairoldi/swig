//
//  SwigCall.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-17.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#include "SwigCall.h"
#import "SWEndpoint.h"
#import "SWAccount.h"
#import "SWCall.h"

void sw::Call::onCallState(pj::OnCallStateParam &prm) {
    
    SWAccount *account = [[SWEndpoint sharedInstance] lookupAccount:getId()];
    SWCall *call = [account lookupCall:getId()];
    
    SWCallState callState;
    
    pj::CallInfo callInfo = getInfo();
    
    switch (callInfo.state) {
            
        case PJSIP_INV_STATE_NULL:
            
            callState = SWCallStateReady;
            break;
            
        case PJSIP_INV_STATE_CALLING:
        case PJSIP_INV_STATE_INCOMING:
            
            callState = SWCallStateCalling;
            break;
            
        case PJSIP_INV_STATE_EARLY:
        case PJSIP_INV_STATE_CONNECTING:
            
            callState = SWCallStateConnecting;
            break;
            
        case PJSIP_INV_STATE_CONFIRMED:
            
            callState = SWCallStateConnected;
            break;
            
        case PJSIP_INV_STATE_DISCONNECTED:
            
            callState = SWCallStateDisconnected;
            break;
            
        default:
            
            callState = SWCallStateReady;
            break;
    }
    
    [call onCallState:callState];
}

/*
 void sw::Call::onCallTsxState(pj::OnCallTsxStateParam &prm) {
 
 }
 */

void sw::Call::onCallMediaState(pj::OnCallMediaStateParam &prm) {
    
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
}

/*
 void sw::Call::onCallSdpCreated(pj::OnCallSdpCreatedParam &prm) {
 
 }
 
 void sw::Call::onStreamCreated(pj::OnStreamCreatedParam &prm) {
 
 }
 
 void sw::Call::onStreamDestroyed(pj::OnStreamDestroyedParam &prm) {
 
 }
 
 void sw::Call::onDtmfDigit(pj::OnDtmfDigitParam &prm) {
 
 }
 
 void sw::Call::onCallTransferRequest(pj::OnCallTransferRequestParam &prm) {
 
 }
 
 void sw::Call::onCallTransferStatus(pj::OnCallTransferStatusParam &prm) {
 
 }
 
 void sw::Call::onCallReplaceRequest(pj::OnCallReplaceRequestParam &prm) {
 
 }
 
 void sw::Call::onCallReplaced(pj::OnCallReplacedParam &prm) {
 
 }
 
 void sw::Call::onCallRxOffer(pj::OnCallRxOfferParam &prm) {
 
 }
 
 void sw::Call::onInstantMessage(pj::OnInstantMessageParam &prm) {
 
 }
 
 void sw::Call::onInstantMessageStatus(pj::OnInstantMessageStatusParam &prm) {
 
 }
 
 void sw::Call::onTypingIndication(pj::OnTypingIndicationParam &prm) {
 
 }
 
 pjsip_redirect_op sw::Call::onCallRedirected(pj::OnCallRedirectedParam &prm) {
 
 }
 
 void sw::Call::onCallMediaTransportState(pj::OnCallMediaTransportStateParam &prm) {
 
 }
 
 void sw::Call::onCallMediaEvent(pj::OnCallMediaEventParam &prm) {
 
 }
 
 void sw::Call::onCreateMediaTransport(pj::OnCreateMediaTransportParam &prm) {
 
 }
 */