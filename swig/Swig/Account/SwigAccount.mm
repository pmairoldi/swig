//
//  SwigAccount.cpp
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#include "SwigAccount.h"
#import "SWEndpoint.h"
#import "SWAccount.h"

void sw::Account::onIncomingCall(pj::OnIncomingCallParam &prm) {

    SWAccount *account = [[SWEndpoint sharedInstance] lookupAccount:getId()];
    
    [account onIncomingCall:prm.callId];
}

void sw::Account::onRegStarted(pj::OnRegStartedParam &prm) {
    
    SWAccount *account = [[SWEndpoint sharedInstance] lookupAccount:getId()];
    
    [account onRegStarted:prm.renew];
}

void sw::Account::onRegState(pj::OnRegStateParam &prm) {
    
    SWAccount *account = [[SWEndpoint sharedInstance] lookupAccount:getId()];
    
    pj::AccountInfo info = getInfo();
    
    SWAccountState accountState;

    if (prm.status == PJ_SUCCESS) {
        
        if (prm.code == 0 || (info.onlineStatus == false)) {
            
            accountState = SWAccountStateOffline;
        }
        
        else if (PJSIP_IS_STATUS_IN_CLASS(prm.code, 100) || PJSIP_IS_STATUS_IN_CLASS(prm.code, 300)) {
        
            accountState = SWAccountStateConnecting;
        }
        
        else if (PJSIP_IS_STATUS_IN_CLASS(prm.code, 200)) {
            
            accountState = SWAccountStateConnected;
        }
        
        else {
            accountState = SWAccountStateInvalid;
        }
    }
    
    else {
        accountState = SWAccountStateInvalid;
    }
    
    [account onRegState:accountState];
}

/*
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
*/