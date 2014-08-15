//
//  SwigAccount.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#include <iostream>
#include <pjsua2/account.hpp>

using namespace pj;

class SwigAccount : public Account {
    
public:
    
    SwigAccount() {}
    ~SwigAccount() {}

    virtual void onIncomingCall(OnIncomingCallParam &prm);
    virtual void onRegStarted(OnRegStartedParam &prm);
    virtual void onRegState(OnRegStateParam &prm);
//    virtual void onIncomingSubscribe(OnIncomingSubscribeParam &prm);
    virtual void onInstantMessage(OnInstantMessageParam &prm);
    virtual void onInstantMessageStatus(OnInstantMessageStatusParam &prm);
    virtual void onTypingIndication(OnTypingIndicationParam &prm);
    virtual void onMwiInfo(OnMwiInfoParam &prm);
};
