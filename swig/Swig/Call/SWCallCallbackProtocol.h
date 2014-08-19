//
//  SWCallCallbackProtocol.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWCallParam.h"

@protocol SWCallCallbackProtocol <NSObject>

-(void)onCallState:(SWOnCallStateParam *)param;
-(void)onCallTsxState:(SWOnCallTsxStateParam *)param;
-(void)onCallMediaState:(SWOnCallMediaStateParam *)param;
-(void)onCallSdpCreated:(SWOnCallSdpCreatedParam *)param;
-(void)onStreamCreated:(SWOnStreamCreatedParam *)param;
-(void)onStreamDestroyed:(SWOnStreamDestroyedParam *)param;
-(void)onDtmfDigit:(SWOnDtmfDigitParam *)param;
-(void)onCallTransferRequest:(SWOnCallTransferRequestParam *)param;
-(void)onCallTransferStatus:(SWOnCallTransferStatusParam *)param;
-(void)onCallReplaceRequest:(SWOnCallReplaceRequestParam *)param;
-(void)onCallReplaced:(SWOnCallReplacedParam *)param;
-(void)onCallRxOffer:(SWOnCallRxOfferParam *)param;
-(void)onInstantMessage:(SWOnInstantMessageParam *)param;
-(void)onInstantMessageStatus:(SWOnInstantMessageStatusParam *)param;
-(void)onTypingIndication:(SWOnTypingIndicationParam *)param;
-(pjsip_redirect_op)onCallRedirected:(SWOnCallRedirectedParam *)param;
-(void)onCallMediaTransportState:(SWOnCallMediaTransportStateParam *)param;
-(void)onCallMediaEvent:(SWOnCallMediaEventParam *)param;
-(void)onCreateMediaTransport:(SWOnCreateMediaTransportParam *)param;

@end
