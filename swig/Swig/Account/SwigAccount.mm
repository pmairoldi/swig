//
//  SwigAccount.cpp
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#include "SwigAccount.h"
#import "SWUserAgent.h"

void sw::Account::onIncomingCall(pj::OnIncomingCallParam &prm) {

    NSLog(@"\n\n\nIncoming Call %d\n\n\n", prm.callId);
}

void sw::Account::onRegStarted(pj::OnRegStartedParam &prm) {

    NSLog(@"\n\n\nRegistration Started\n\n\n");
}

void sw::Account::onRegState(pj::OnRegStateParam &prm) {

    NSLog(@"\n\n\nRegistration State %d\n\n\n", prm.status);
}

void sw::Account::onIncomingSubscribe(pj::OnIncomingSubscribeParam &prm) {
    
}

void sw::Account::onInstantMessage(pj::OnInstantMessageParam &prm) {
    
}

void sw::Account::onInstantMessageStatus(pj::OnInstantMessageStatusParam &prm) {
    
}

void sw::Account::onTypingIndication(pj::OnTypingIndicationParam &prm) {
    
}

void sw::Account::onMwiInfo(pj::OnMwiInfoParam &prm) {
    
}
