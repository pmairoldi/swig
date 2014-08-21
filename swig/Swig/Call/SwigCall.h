//
//  SwigCall.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-17.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#include "SwigAccount.h"

#ifndef SW_CALL_H
#define SW_CALL_H

#include "pjsua2/call.hpp"

namespace sw {
    
    class Call : public pj::Call {
        
    public:
        
        Call(sw::Account &acc, int call_id = PJSUA_INVALID_ID) : pj::Call(acc, call_id) {};
        ~Call() {};
        
        static Call *lookup(int call_id) {
            
            pj::Call *call = pj::Call::lookup(call_id);
            
            return (sw::Call *)call;
        };
        
        virtual void onCallState(pj::OnCallStateParam &prm);
//        virtual void onCallTsxState(pj::OnCallTsxStateParam &prm);
        virtual void onCallMediaState(pj::OnCallMediaStateParam &prm);
//        virtual void onCallSdpCreated(pj::OnCallSdpCreatedParam &prm);
//        virtual void onStreamCreated(pj::OnStreamCreatedParam &prm);
//        virtual void onStreamDestroyed(pj::OnStreamDestroyedParam &prm);
//        virtual void onDtmfDigit(pj::OnDtmfDigitParam &prm);
//        virtual void onCallTransferRequest(pj::OnCallTransferRequestParam &prm);
//        virtual void onCallTransferStatus(pj::OnCallTransferStatusParam &prm);
//        virtual void onCallReplaceRequest(pj::OnCallReplaceRequestParam &prm);
//        virtual void onCallReplaced(pj::OnCallReplacedParam &prm);
//        virtual void onCallRxOffer(pj::OnCallRxOfferParam &prm);
//        virtual void onInstantMessage(pj::OnInstantMessageParam &prm);
//        virtual void onInstantMessageStatus(pj::OnInstantMessageStatusParam &prm);
//        virtual void onTypingIndication(pj::OnTypingIndicationParam &prm);
//        virtual pjsip_redirect_op onCallRedirected(pj::OnCallRedirectedParam &prm);
//        virtual void onCallMediaTransportState(pj::OnCallMediaTransportStateParam &prm);
//        virtual void onCallMediaEvent(pj::OnCallMediaEventParam &prm);
//        virtual void onCreateMediaTransport(pj::OnCreateMediaTransportParam &prm);
    };
}

#endif