//
//  SWUserAgent.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWUserAgent.h"
#import "Swig.h"
#import "SWAuthCredInfo.h"

@interface SWUserAgent ()

@property (nonatomic, strong) SWEndpoint *endpoint;
@property (nonatomic, strong) NSMutableArray *accounts;

@end

@implementation SWUserAgent

static SWUserAgent *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}

#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[SWUserAgent alloc] init];
}

- (id)mutableCopy
{
    return [[SWUserAgent alloc] init];
}

- (id) init
{
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
    
    //TODO dont leave this here for release
    SWTransportConfiguration *config1 = [[SWTransportConfiguration alloc] initWithTransportType:PJSIP_TRANSPORT_UDP];
    
    SWTransportConfiguration *config2 = [[SWTransportConfiguration alloc] initWithTransportType:PJSIP_TRANSPORT_TCP];
    
    _endpoint = [[SWEndpoint alloc] init];
    _endpoint.transportConfigurations = @[config1];
    
    [_endpoint begin];
    
    SWAccountConfiguration *accountConfiguration = [[SWAccountConfiguration alloc] initWithURI:@"sip:mobila@getonsip.com"];
    
    NSMutableArray *auth = [accountConfiguration.sipConfig.authCreds mutableCopy];
    
    SWAuthCredInfo *authInfo = [SWAuthCredInfo new];
    authInfo.scheme = @"digest";
    authInfo.realm = @"*";
    authInfo.username = @"getonsip_mobila";
    authInfo.data = @"NQFxmwxw4wQMEfp3";

    [auth addObject:authInfo];
    
    accountConfiguration.sipConfig.authCreds = auth;
    
    NSMutableArray *proxy = [accountConfiguration.sipConfig.proxies mutableCopy];
    
    [proxy addObject:@"sip:sip.onsip.com"];
    
    accountConfiguration.sipConfig.proxies = proxy;
    
    accountConfiguration.regConfig.registrarUri = @"sip:getonsip.com";
    
    SWAccount *account = [[SWAccount alloc] initWithAccountConfiguration:accountConfiguration];
    
    [self addAccount:account];
    
    return self;
}

-(void)addAccount:(SWAccount *)account {
    
    [account createWithSuccess:^{
        [self.accounts addObject:account];
        
        [account makeCall:@"sip:trac@getonsip.com"];
        
    } failure:^(NSError *error) {
        NSLog(@"%@", [error description]);
    }];
}

-(SWAccount *)accountFromId:(NSInteger)accountId {
    
    if (self.accounts.count == 0) {
        return nil;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        
        SWAccount *account = (SWAccount *)evaluatedObject;
        
        if (account.getId == accountId) {
            
            return YES;
        }
        
        else {
            return NO;
        }
    }];
    
    NSArray *array = [self.accounts filteredArrayUsingPredicate:predicate];
    
    SWAccount *account = [array firstObject];
    
    return account;
}


@end
