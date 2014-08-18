//
//  SwigAccount.cpp
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWAccount.h"
#import "SWUserAgent.h"

void sw::Account::onIncomingCall(pj::OnIncomingCallParam &prm) {

    SWUserAgent *userAgent = [SWUserAgent sharedInstance];
    SWAccount *account = [userAgent accountWithId:getId()];
    
    [account onIncomingCall:[SWOnIncomingCallParam onParamFromParam:prm]];
}

void sw::Account::onRegStarted(pj::OnRegStartedParam &prm) {

    SWUserAgent *userAgent = [SWUserAgent sharedInstance];
    SWAccount *account = [userAgent accountWithId:getId()];
    
    [account onRegStarted:[SWOnRegStartedParam onParamFromParam:prm]];
}

void sw::Account::onRegState(pj::OnRegStateParam &prm) {

    SWUserAgent *userAgent = [SWUserAgent sharedInstance];
    SWAccount *account = [userAgent accountWithId:getId()];
    
    [account onRegState:[SWOnRegStateParam onParamFromParam:prm]];
}

void sw::Account::onIncomingSubscribe(pj::OnIncomingSubscribeParam &prm) {
    
    SWUserAgent *userAgent = [SWUserAgent sharedInstance];
    SWAccount *account = [userAgent accountWithId:getId()];
    
    [account onIncomingSubscribe:[SWOnIncomingSubscribeParam onParamFromParam:prm]];
}

void sw::Account::onInstantMessage(pj::OnInstantMessageParam &prm) {
    
    SWUserAgent *userAgent = [SWUserAgent sharedInstance];
    SWAccount *account = [userAgent accountWithId:getId()];
    
    [account onInstantMessage:[SWOnInstantMessageParam onParamFromParam:prm]];
}

void sw::Account::onInstantMessageStatus(pj::OnInstantMessageStatusParam &prm) {
    
    SWUserAgent *userAgent = [SWUserAgent sharedInstance];
    SWAccount *account = [userAgent accountWithId:getId()];
    
    [account onInstantMessageStatus:[SWOnInstantMessageStatusParam onParamFromParam:prm]];
}

void sw::Account::onTypingIndication(pj::OnTypingIndicationParam &prm) {
    
    SWUserAgent *userAgent = [SWUserAgent sharedInstance];
    SWAccount *account = [userAgent accountWithId:getId()];
    
    [account onTypingIndication:[SWOnTypingIndicationParam onParamFromParam:prm]];
}

void sw::Account::onMwiInfo(pj::OnMwiInfoParam &prm) {
    
    SWUserAgent *userAgent = [SWUserAgent sharedInstance];
    SWAccount *account = [userAgent accountWithId:getId()];
    
    [account onMwiInfo:[SWOnMwiInfoParam onParamFromParam:prm]];
}
