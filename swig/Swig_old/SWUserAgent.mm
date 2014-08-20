//
//  SWUserAgent.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-15.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWUserAgent.h"
#import "Swig.h"

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
    
    _endpoint = [[SWEndpoint alloc] init];
    _accounts = [NSMutableArray new];
    
    return self;
}

-(void)beginWithTransportConfigurations:(NSArray *)transportConfigurations {
    
    if (transportConfigurations.count == 0) {
    
        SWTransportConfiguration *config = [[SWTransportConfiguration alloc] initWithTransportType:PJSIP_TRANSPORT_UDP];
    
        _endpoint.transportConfigurations = @[config];
    }
    
    else {
        _endpoint.transportConfigurations = transportConfigurations;
    }
    
    [_endpoint begin];
}

-(void)addAccount:(SWAccount *)account {
    
    [account createWithSuccess:^{
        [self.accounts addObject:account];
    } failure:^(NSError *error) {
        NSLog(@"%@", [error description]);
    }];
}

-(SWAccount *)accountWithId:(NSInteger)accountId {
    
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
