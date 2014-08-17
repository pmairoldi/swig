//
//  SwigAccount.cpp
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#include "SwigAccount.h"
#import "SWUserAgent.h"

void SwigAccount::onIncomingCall(OnIncomingCallParam &prm) {

    NSLog(@"\n\n\nIncoming Call %d\n\n\n", prm.callId);
}

void SwigAccount::onRegStarted(OnRegStartedParam &prm) {

    NSLog(@"\n\n\nRegistration Started\n\n\n");
}

void SwigAccount:: onRegState(OnRegStateParam &prm) {

    NSLog(@"\n\n\nRegistration State %d\n\n\n", prm.status);
}

//void SwigAccount::onIncomingSubscribe(OnIncomingSubscribeParam &prm) {
//    
//}

void SwigAccount::onInstantMessage(OnInstantMessageParam &prm) {
    
}

void SwigAccount::onInstantMessageStatus(OnInstantMessageStatusParam &prm) {
    
}

void SwigAccount::onTypingIndication(OnTypingIndicationParam &prm) {
    
}

void SwigAccount::onMwiInfo(OnMwiInfoParam &prm) {
    
}
