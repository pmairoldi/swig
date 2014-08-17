//
//  SWAccount.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWAccount.h"
#import "SwigAccount.h"
#import "NSError+Error.h"
#include "pjsua2/call.hpp"
#import "NSString+String.h"

@interface SWAccount ()

@property SWAccountConfiguration *accountConfiguration;
@property sw::Account *account;

@end

@implementation SWAccount

-(instancetype)init {
    
    return [self initWithAccountConfiguration:nil];
}

-(instancetype)initWithAccountConfiguration:(SWAccountConfiguration *)accountConfiguration {
    
    if (!accountConfiguration) {
        NSAssert(@"no account configuration", @"you must specify the account configuration to create an account");
        return nil;
    }
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _accountConfiguration = accountConfiguration;
        
    return self;
}

-(instancetype)initWithSwigAccoung:(sw::Account *)swigAccount {
    
    self = [super init];
    
    if (self) {
        return nil;
    }
    
    _account = swigAccount;
    _accountConfiguration = [SWAccountConfiguration accountConfigurationFromAccountId:swigAccount->getId()];
    return self;
}

-(void)createWithSuccess:(void (^)())success failure:(void (^)(NSError *error))failure {
    
    NSError *error;
    
    if (!self.account) {
        self.account = new sw::Account;
    }
    
    try {
        pj::AccountConfig config = self.accountConfiguration.config;
        
        self.account->create(config);
    } catch(pj::Error& err) {
        error = [NSError errorWithError:&err];
    }
    
    if (error) {
        if (failure) {
            failure(error);
        }
    }
    
    else {
        if (success) {
            success();
        }
    }
}

-(NSInteger)getId {
    
    return self.account->getId();
}

-(void)makeCall:(NSString *)number {
    
//    self.call = new Call(*(self.account), PJSUA_INVALID_ID);
//    
//    CallOpParam prm = NULL;
//    const std::string uri = *[number CPPString];
//    
//    try {
//        self.call->makeCall(uri, prm);
//    } catch(pj::Error& err)  {
//        NSError *error = [NSError errorWithError:&err];
//    }
}

@end
