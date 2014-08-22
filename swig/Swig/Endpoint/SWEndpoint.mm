//
//  SWEndpoint.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-20.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWEndpoint.h"
#import "pjsua2.hpp"
#import "NSError+Error.h"
#import "SWEndpointConfiguration+EpConfig.h"
#import "SWTransportConfiguration.h"
#import "SWEndpointConfiguration.h"
#import "SWTransportConfiguration+TransportConfig.h"
#import "SWAccount.h"

typedef void (^SWAccountSIncomingCallBlock)(__weak SWAccount *account, __weak SWCall *call);
typedef void (^SWAccountStateChangeBlock)(__weak SWAccount *account, SWAccountState state);

@interface SWEndpoint ()

@property (nonatomic) pj::Endpoint *endpoint;
@property (nonatomic, strong) NSMutableDictionary *accounts;
@property (nonatomic, copy) SWAccountSIncomingCallBlock accountIncomingCallBlock;
@property (nonatomic, copy) SWAccountStateChangeBlock accountStateChangeBlock;

@end

@implementation SWEndpoint

static SWEndpoint *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+(id)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}

#pragma mark - Life Cycle

+(id) allocWithZone:(NSZone *)zone {
    return [self sharedInstance];
}

+(id)copyWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

+(id)mutableCopyWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

-(id)copy {
    return [[SWEndpoint alloc] init];
}

-(id)mutableCopy {
    return [[SWEndpoint alloc] init];
}

-(id)init {
    
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _accounts = [NSMutableDictionary dictionary];
    
    return self;
}

-(void)dealloc {
    
    if (_endpoint){
        delete _endpoint;
    }
}

-(pj::Endpoint *)endpoint {
    
    if (!_endpoint) {
        
        _endpoint = new pj::Endpoint;
    }
    
    else {
        _endpoint = &pj::Endpoint::instance();
    }
    
    return _endpoint;
}

-(void)setEndpointConfiguration:(SWEndpointConfiguration *)endpointConfiguration {
    
    [self willChangeValueForKey:@"endpointConfiguration"];
    _endpointConfiguration = endpointConfiguration;
    [self didChangeValueForKey:@"endpointConfiguration"];
}

-(void)configure:(SWEndpointConfiguration *)configuration completionHandler:(void(^)(NSError *error))handler {
    
    self.endpointConfiguration = configuration;
    
    try {
        
        self.endpoint->libCreate();
        
        pj::EpConfig *epConfig = [self.endpointConfiguration toEpConfig];
        
        self.endpoint->libInit(*epConfig);
        
        for (SWTransportConfiguration *transport in self.endpointConfiguration.transportConfigurations) {
            
            pj::TransportConfig *transportConfig = [transport toTransportConfig];
            
            pjsip_transport_type_e transportType = (pjsip_transport_type_e)transport.transportType;
            
            self.endpoint->transportCreate(transportType, *transportConfig);
        }
        
        self.endpoint->libStart();
        
    } catch(pj::Error &err) {
       
        NSError *error = [NSError errorWithError:&err];
  
        if (handler) {
            handler(error);
        }
    }
    
    if (handler) {
        handler(nil);
    }
}

-(BOOL)hasTCPConfiguration {

    NSUInteger index = [self.endpointConfiguration.transportConfigurations indexOfObjectPassingTest:^BOOL(SWTransportConfiguration *obj, NSUInteger idx, BOOL *stop) {
       
        if (obj.transportType == SWTransportTypeTCP || obj.transportType == SWTransportTypeTCP6) {
            return YES;
            *stop = YES;
        }
        
        else {
            return NO;
        }
    }];
    
    if (index == NSNotFound) {
        return NO;
    }
    
    else {
        return YES;
    }
}

//-(void)start:(void(^)(NSError *error))handler {
//    
//    try {
//        
//        self.endpoint->libStart();
//        
//        if (handler) {
//            handler(nil);
//        }
//        
//    } catch(pj::Error &err) {
//       
//        NSError *error = [NSError errorWithError:&err];
//    
//        if (handler) {
//            handler(error);
//        }
//    }
//}

-(void)reset:(void(^)(NSError *error))handler {
    
    //TODO
    /**
     * Destroy pjsua. Application is recommended to perform graceful shutdown
     * before calling this function (such as unregister the account from the
     * SIP server, terminate presense subscription, and hangup active calls),
     * however, this function will do all of these if it finds there are
     * active sessions that need to be terminated. This function will
     * block for few seconds to wait for replies from remote.
     *
     * Application.may safely call this function more than once if it doesn't
     * keep track of it's state.
     *
     * @param prmFlags	Combination of pjsua_destroy_flag enumeration.
     */

    try {
        
        self.endpoint->libDestroy();
                
        if (handler) {
            handler(nil);
        }
        
    } catch(pj::Error &err) {
        
        NSError *error = [NSError errorWithError:&err];
        
        if (handler) {
            handler(error);
        }
    }
}

#pragma Account Management

-(void)addAccount:(SWAccount *)account {
    
    [self.accounts setObject:account forKey:@(account.accountId)];
 
    __weak SWAccount *weak_account = account;
    
    [weak_account setIncomingCallBlock:^(__weak SWCall *call) {
       
        if (self.accountIncomingCallBlock) {
            self.accountIncomingCallBlock(weak_account, call);
        }
    }];
    
    [weak_account setStateChangeBlock:^(SWAccountState state) {
        
        if (self.accountStateChangeBlock) {
            self.accountStateChangeBlock(weak_account, state);
        }
    }];
}

-(SWAccount *)lookupAccount:(NSInteger)accountId {
    
    if ([[self.accounts allKeys] containsObject:@(accountId)]) {
        return [self.accounts objectForKey:@(accountId)];
    }
    
    else {
        return nil;
    }
}

#pragma Block Parameters 

-(void)setAccountIncomingCallBlock:(void(^)(__weak SWAccount *account, __weak SWCall *call))accountIncomingCallBlock {
    
    _accountIncomingCallBlock = accountIncomingCallBlock;
}

-(void)setAccountStateChangeBlock:(void(^)(__weak SWAccount *account, SWAccountState state))accountStateChangeBlock {

    _accountStateChangeBlock = accountStateChangeBlock;
}

@end
