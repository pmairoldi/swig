//
//  SWAccount.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWAccountConfiguration.h"
#import "SWAccountCallbackProtocol.h"

@interface SWAccount : NSObject <SWAccountCallbackProtocol>

@property (nonatomic, weak) id<SWAccountCallbackProtocol> delegate;

//TODO add class methods

//bool isValid() const;
//void setDefault() throw(Error);
//bool isDefault() const;
-(NSInteger)getId;
//static Account *lookup(int acc_id);
//AccountInfo getInfo() const throw(Error);
//void setRegistration(bool renew) throw(Error);
//void setOnlineStatus(const PresenceStatus &pres_st) throw(Error);
//void setTransport(TransportId tp_id) throw(Error);
//void presNotify(const PresNotifyParam &prm) throw(Error);
//const BuddyVector& enumBuddies() const throw(Error);
//Buddy* findBuddy(string uri, FindBuddyMatch *buddy_match = NULL) const
//throw(Error);
//void addBuddy(Buddy *buddy);
//void removeBuddy(Buddy *buddy);

-(instancetype)initWithAccountConfiguration:(SWAccountConfiguration *)accountConfiguration;
-(void)createWithSuccess:(void (^)())success failure:(void (^)(NSError *error))failure;
-(void)makeCall:(NSString *)number;

//-(void)onIncomingCall:(SWOnIncomingCallParam *)param;
//-(void)onRegStarted:(SWOnRegStartedParam *)param;
//-(void)onRegState:(SWOnRegStateParam *)param;
//-(void)onIncomingSubscribe:(SWOnIncomingSubscribeParam *)param;
//-(void)onInstantMessage:(SWOnInstantMessageParam *)param;
//-(void)onInstantMessageStatus:(SWOnInstantMessageStatusParam *)param;
//-(void)onTypingIndication:(SWOnTypingIndicationParam *)param;
//-(void)onMwiInfo:(SWOnMwiInfoParam *)param;
@end
