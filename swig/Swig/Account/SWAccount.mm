//
//  SWAccount.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWAccount.h"
#import "NSError+Error.h"
#import "NSString+String.h"
#import "SWAccountConfiguration.h"
#import "SWCall.h"

@interface SWAccount ()

@property (nonatomic, strong) SWAccountConfiguration *accountConfiguration;
@property (nonatomic, strong) NSMutableArray *calls;
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
    _calls = [NSMutableArray new];
    
    return self;
}

-(instancetype)initWithSwigAccoung:(sw::Account *)swigAccount {
    
    self = [self initWithAccountConfiguration:[SWAccountConfiguration accountConfigurationFromAccountId:swigAccount->getId()]];
    
    if (!self) {
        return nil;
    }
    
    _account = swigAccount;
   
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

-(sw::Account *)swigAccount {
    
    return self.account;
}

#pragma SWCallMethods

-(SWCall *)callWithId:(NSInteger)callId {
    
    if (self.calls.count == 0) {
        return nil;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        
        SWCall *call = (SWCall *)evaluatedObject;
        
        if (call.getId == callId) {
            
            return YES;
        }
        
        else {
            return NO;
        }
    }];
    
    NSArray *array = [self.calls filteredArrayUsingPredicate:predicate];
    
    SWCall *call = [array firstObject];
    
    return call;
}

-(void)makeCall:(NSString *)destinationUri callOpParams:(SWCallOpParam *)callOpParams {

    SWCall *call = [SWCall callFromAccount:self];

    [call makeCall:destinationUri callOpParams:callOpParams success:^{
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma SWAccountCallbackProtocol

-(void)onIncomingCall:(SWOnIncomingCallParam *)param {
    
    SWCall *call = [SWCall callWithId:param.callId account:self];
    
    [call answer:nil success:^{
        
    } failure:^(NSError *error) {
        
    }];
    
    //TODO: add implementation
    NSLog(@"\n\n\n%@\n\n\n", @"onIncomingCall");
    
    if (self.delegate) {
        [self.delegate onIncomingCall:param];
    }
}

-(void)onRegStarted:(SWOnRegStartedParam *)param {
    
    //TODO: add implementation
    NSLog(@"\n\n\n%@\n\n\n", @"onRegStarted");
    
    if (self.delegate) {
        [self.delegate onRegStarted:param];
    }
}

-(void)onRegState:(SWOnRegStateParam *)param {
    
    //TODO: add implementation
    NSLog(@"\n\n\n%@\n\n\n", @"onRegState");
    
    if (self.delegate) {
        [self.delegate onRegState:param];
    }
}

-(void)onIncomingSubscribe:(SWOnIncomingSubscribeParam *)param {
    
    //TODO: add implementation
    NSLog(@"\n\n\n%@\n\n\n", @"onIncomingSubscribe");
    
    if (self.delegate) {
        [self.delegate onIncomingSubscribe:param];
    }
}

-(void)onInstantMessage:(SWOnInstantMessageParam *)param {
    
    //TODO: add implementation
    NSLog(@"\n\n\n%@\n\n\n", @"onInstantMessage");
    
    if (self.delegate) {
        [self.delegate onInstantMessage:param];
    }
}

-(void)onInstantMessageStatus:(SWOnInstantMessageStatusParam *)param {
    
    //TODO: add implementation
    NSLog(@"\n\n\n%@\n\n\n", @"onInstantMessageStatus");
    
    if (self.delegate) {
        [self.delegate onInstantMessageStatus:param];
    }
}

-(void)onTypingIndication:(SWOnTypingIndicationParam *)param {
    
    //TODO: add implementation
    NSLog(@"\n\n\n%@\n\n\n", @"onTypingIndication");
    
    if (self.delegate) {
        [self.delegate onTypingIndication:param];
    }
}

-(void)onMwiInfo:(SWOnMwiInfoParam *)param {
    
    //TODO: add implementation
    NSLog(@"\n\n\n%@\n\n\n", @"onMwiInfo");
    
    if (self.delegate) {
        [self.delegate onMwiInfo:param];
    }
}

@end
