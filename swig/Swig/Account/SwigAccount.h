//
//  SwigAccount.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#include <iostream>
#include <pjsua2/account.hpp>

namespace sw {
    
    class Account : public pj::Account {
        
    public:
        
        Account() {}
        ~Account() {}
        
        virtual void onIncomingCall(pj::OnIncomingCallParam &prm);
        virtual void onRegStarted(pj::OnRegStartedParam &prm);
        virtual void onRegState(pj::OnRegStateParam &prm);
        virtual void onIncomingSubscribe(pj::OnIncomingSubscribeParam &prm);
        virtual void onInstantMessage(pj::OnInstantMessageParam &prm);
        virtual void onInstantMessageStatus(pj::OnInstantMessageStatusParam &prm);
        virtual void onTypingIndication(pj::OnTypingIndicationParam &prm);
        virtual void onMwiInfo(pj::OnMwiInfoParam &prm);
    };
}