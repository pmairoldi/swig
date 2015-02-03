//
//  SWAppDelegate.m
//  Swig
//
//  Created by CocoaPods on 09/01/2014.
//  Copyright (c) 2014 Pierre-Marc Airoldi. All rights reserved.
//

#import "SWAppDelegate.h"
#import <Swig/Swig.h>

@implementation SWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [self configureEndpoint];
    [self addSIPAccount];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)configureEndpoint {
    
    SWTransportConfiguration *udp = [SWTransportConfiguration configurationWithTransportType:SWTransportTypeUDP];
//    udp.port = 5060;
    
//    SWTransportConfiguration *tcp = [SWTransportConfiguration configurationWithTransportType:SWTransportTypeTCP];
//    tcp.port = 5060;
    
    SWEndpointConfiguration *endpointConfiguration = [SWEndpointConfiguration configurationWithTransportConfigurations:@[udp]];
    
    SWEndpoint *endpoint = [SWEndpoint sharedEndpoint];
    
    [endpoint configure:endpointConfiguration completionHandler:^(NSError *error) {
        
        if (error) {
            
            NSLog(@"%@", [error description]);
            
            [endpoint reset:^(NSError *error) {
                if(error) NSLog(@"%@", [error description]);
            }];
        }
    }];
    
    [endpoint setIncomingCallBlock:^(SWAccount *account, SWCall *call) {
        
        NSLog(@"\n\nIncoming Call : %d\n\n", (int)call.callId);
        
    }];
    
    [endpoint setAccountStateChangeBlock:^(SWAccount *account) {
        
        NSLog(@"\n\nAccount State : %ld\n\n", (long)account.accountState);
    }];
    
    [endpoint setCallStateChangeBlock:^(SWAccount *account, SWCall *call) {
        
        NSLog(@"\n\nCall State : %ld\n\n", (long)call.callState);
    }];
    
    [endpoint setCallMediaStateChangeBlock:^(SWAccount *account, SWCall *call) {
        
        NSLog(@"\n\nMedia State Changed\n\n");
    }];
}

-(void)addSIPAccount {
    
    SWAccount *account = [SWAccount new];
    
    SWAccountConfiguration *configuration = [SWAccountConfiguration new];
    configuration.username = @"getonsip_swig";
    configuration.password = @"ggV4CUoHmXa9BaXG";
    configuration.domain = @"getonsip.com";
    configuration.address = [SWAccountConfiguration addressFromUsername:@"swig" domain:configuration.domain];
    configuration.proxy = @"sip.onsip.com";
    configuration.registerOnAdd = YES;
    
    [account configure:configuration completionHandler:^(NSError *error) {
        
        if (error) {
            NSLog(@"%@", [error description]);
        }
        
    }];
}

@end
