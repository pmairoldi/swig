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
#import "AppDelegate.h"

@interface SWAccount ()

@property (nonatomic, strong) SWAccountConfiguration *accountConfiguration;
@property (nonatomic, strong) NSMutableArray *calls;
@property sw::Account *account;

@end

@implementation SWAccount

+(SWAccount *)lookup:(NSInteger)accountId {
    
    
}

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

-(void)dealloc {
    
    delete _account;
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

    [call makeCall:destinationUri callOpParams:callOpParams completion:^(NSError *error) {
        
    }];
}

#pragma SWAccountCallbackProtocol

-(void)onIncomingCall:(SWOnIncomingCallParam *)param {
    
    SWCall *call = [SWCall callWithId:param.callId account:self];

    [self showIncomingCallAlert];

//    [call answer:nil completion:^(NSError *error) {
//        
//    }];
    
//    [call answer:nil success:^{
//        
//    } failure:^(NSError *error) {
//        
//    }];
    
    //TODO: add implementation
}

-(void)showIncomingCallAlert {
    
    // Create a new notification
    UILocalNotification* alert = [[UILocalNotification alloc] init];
    alert.repeatInterval = 0;
    alert.alertBody = @"Incoming call received...";
    alert.alertAction = @"Activate app";
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:alert];
}

-(void)onRegStarted:(SWOnRegStartedParam *)param {
    
    //TODO: add implementation
}

-(void)onRegState:(SWOnRegStateParam *)param {
    
    self.isValid = self.account->isValid();
    self.isDefault = self.account->isDefault();
    self.accountId = self.account->getId();
}

-(void)onIncomingSubscribe:(SWOnIncomingSubscribeParam *)param {
    
    //TODO: add implementation
}

-(void)onInstantMessage:(SWOnInstantMessageParam *)param {
    
    //TODO: add implementation
}

-(void)onInstantMessageStatus:(SWOnInstantMessageStatusParam *)param {
    
    //TODO: add implementation
}

-(void)onTypingIndication:(SWOnTypingIndicationParam *)param {
    
    //TODO: add implementation
}

-(void)onMwiInfo:(SWOnMwiInfoParam *)param {
    
    //TODO: add implementation
}

#pragma Setters & Getters

-(void)setIsValid:(BOOL)isValid {
    
    if (_isValid == isValid) {
        return;
    }
    
    [self willChangeValueForKey:@"isValid"];
    _isValid = isValid;
    [self didChangeValueForKey:@"isValid"];
}

-(void)setIsDefault:(BOOL)isDefault {
 
    if (_isDefault == isDefault) {
        return;
    }
    
    if (_isDefault == NO && isDefault == YES) {
       
        try {
            self.account->setDefault();
        } catch (pj::Error *error) {
            NSLog(@"%@",[[NSError errorWithError:error] description]);
        }
    }

    [self willChangeValueForKey:@"isDefault"];
    _isDefault = self.account->isDefault();
    [self didChangeValueForKey:@"isDefault"];
}

-(void)setAccountId:(NSInteger)accountId {
    
    if (_accountId == accountId) {
        return;
    }
    
    [self willChangeValueForKey:@"accountId"];
    _accountId = accountId;
    [self didChangeValueForKey:@"accountId"];

}

@end
