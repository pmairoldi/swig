//
//  SWAccountNATConfiguration.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#include <pjsua2/account.hpp>
#endif

@interface SWAccountNATConfiguration : NSObject

@property (nonatomic) pjsua_stun_use sipStunUse;
@property (nonatomic) pjsua_stun_use mediaStunUse;
@property (nonatomic) BOOL iceEnabled;
@property (nonatomic) NSInteger iceMaxHostCands;
@property (nonatomic) BOOL iceAggressiveNomination;
@property (nonatomic) NSUInteger iceNominatedCheckDelayMsec;
@property (nonatomic) NSInteger iceWaitNominationTimeoutMsec;
@property (nonatomic) BOOL iceNoRtcp;
@property (nonatomic) BOOL iceAlwaysUpdate;
@property (nonatomic) BOOL turnEnabled;
@property (nonatomic, strong) NSString *turnServer;
@property (nonatomic) pj_turn_tp_type turnConnType;
@property (nonatomic, strong) NSString *turnUserName;
@property (nonatomic) NSInteger turnPasswordType;
@property (nonatomic, strong) NSString *turnPassword;
@property (nonatomic) NSInteger contactRewriteUse;
@property (nonatomic) NSInteger contactRewriteMethod;
@property (nonatomic) NSInteger viaRewriteUse;
@property (nonatomic) NSInteger sdpNatRewriteUse;
@property (nonatomic) NSInteger sipOutboundUse;
@property (nonatomic, strong) NSString *sipOutboundInstanceId;
@property (nonatomic, strong) NSString *sipOutboundRegId;
@property (nonatomic) NSUInteger udpKaIntervalSec;
@property (nonatomic, strong) NSString *udpKaData;

#ifdef __cplusplus
-(pj::AccountNatConfig)config;
#endif

@end
