//
//  SWAccount.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-21.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

//TODO: remove account from accounts when disconnected

@class SWAccountConfiguration, SWCall;

typedef NS_ENUM(NSInteger, SWAccountState) {
    SWAccountStateDisconnected,
    SWAccountStateConnecting,
    SWAccountStateConnected,
    SWAccountStateOffline
};

@interface SWAccount : NSObject

@property (nonatomic, readonly) NSInteger accountId;
@property (nonatomic, readonly) SWAccountState accountState;
@property (nonatomic, readonly, strong) SWAccountConfiguration *accountConfiguration;
@property (nonatomic, readonly , assign, getter=isValid) BOOL valid;

-(void)configure:(SWAccountConfiguration *)configuration completionHandler:(void(^)(NSError *error))handler; //configure and add account
-(void)connect:(void(^)(NSError *error))handler;
-(void)disconnect:(void(^)(NSError *error))handler;
-(void)accountStateChanged;

-(void)addCall:(SWCall *)call;
-(void)removeCall:(NSUInteger)callId;
-(SWCall *)lookupCall:(NSInteger)callId;

-(void)makeCall:(NSString *)URI completionHandler:(void(^)(NSError *error))handler;
//-(void)answerCall:(NSUInteger)callId completionHandler:(void(^)(NSError *error))handler;
//-(void)endCall:(NSInteger)callId completionHandler:(void(^)(NSError *error))handler;

@end
