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

@interface SWAccount ()

@property SWAccountConfiguration *accountConfiguration;
@property SwigAccount *account;

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
    
    [self createWithSuccess:^{
        
    } failure:^(NSError *error) {
        
    }];
    
    return self;
}

-(void)createWithSuccess:(void (^)())success failure:(void (^)(NSError *error))failure {
    
    NSError *error;
    
    if (!self.account) {
        self.account = new SwigAccount;
    }
    
    try {
        self.account->create(self.accountConfiguration.config);
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

+(SWAccount *)accountForId:(NSInteger)accountId {
    
    // pj::Account::lookup(accountId)
    return [SWAccount new];
}

@end
