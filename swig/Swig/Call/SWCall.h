//
//  SWCall.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pjsua.h"
#import "SWCallCallbackProtocol.h"

//#import "SWAccount.h"
//#import "SWCallOpParams.h"

@class SWAccount, SWCallOpParam;

@interface SWCall : NSObject <SWCallCallbackProtocol>

//CallInfo getInfo() const throw(Error);
//bool isActive() const;
-(NSInteger)getId;
//static Call *lookup(int call_id);
//bool hasMedia() const;
//Media *getMedia(unsigned med_idx) const;
//pjsip_dialog_cap_status remoteHasCap(int htype, const string &hname, const string &token) const;
//void setUserData(Token user_data);
//Token getUserData() const;
//pj_stun_nat_type getRemNatType() throw(Error);
-(void)makeCall:(NSString *)destinationUri callOpParams:(SWCallOpParam *)param completion:(void(^)(NSError *error))completion;
-(void)answer:(SWCallOpParam *)param completion:(void(^)(NSError *error))completion;
-(void)hangup:(SWCallOpParam *)param completion:(void(^)(NSError *error))completion;
-(void)setHold:(SWCallOpParam *)param completion:(void(^)(NSError *error))completion;
-(void)reinvite:(SWCallOpParam *)param completion:(void(^)(NSError *error))completion;
-(void)update:(SWCallOpParam *)param completion:(void(^)(NSError *error))completion;

//void xfer(const string &dest, const CallOpParam &prm) throw(Error);
//void xferReplaces(const Call& dest_call, const CallOpParam &prm) throw(Error);
//void processRedirect(pjsip_redirect_op cmd) throw(Error);
//void dialDtmf(const string &digits) throw(Error);
//void sendInstantMessage(const SendInstantMessageParam& prm) throw(Error);
//void sendTypingIndication(const SendTypingIndicationParam &prm) throw(Error);
//void sendRequest(const CallSendRequestParam &prm) throw(Error);
//string dump(bool with_media, const string indent) throw(Error);
//int vidGetStreamIdx() const;
//bool vidStreamIsRunning(int med_idx, pjmedia_dir dir) const;
//void vidSetStream(pjsua_call_vid_strm_op op, const CallVidSetStreamParam &param) throw(Error);
//StreamInfo getStreamInfo(unsigned med_idx) const throw(Error);
//StreamStat getStreamStat(unsigned med_idx) const throw(Error);
//MediaTransportInfo getMedTransportInfo(unsigned med_idx) const throw(Error);
//void processMediaUpdate(OnCallMediaStateParam &prm);
//void processStateChange(OnCallStateParam &prm);

+(instancetype)callWithId:(NSInteger)callId account:(SWAccount *)calledAccount;
+(instancetype)callFromAccount:(SWAccount *)calledAccount;

@end
