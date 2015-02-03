//
//  AppDelegate.swift
//  Swig-Swift
//
//  Created by Pierre-Marc Airoldi on 2015-01-29.
//  Copyright (c) 2015 Pierre-Marc Airoldi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        configureEndpoint();
        addSipAccount();
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate {
    
    func configureEndpoint() {
        
        let udp = SWTransportConfiguration(transportType: SWTransportType.UDP)
        //let udp = SWTransportConfiguration(transportType: SWTransportType.TCP)
        
        let endpointConfiguration = SWEndpointConfiguration(transportConfigurations: [udp])
        let endpoint = SWEndpoint.sharedEndpoint()
        
        endpoint.configure(endpointConfiguration, completionHandler: { (error) in
            
            if error != nil {
                
                println(error)
                
                //strong retain cycle!
                endpoint.reset({ (error) in
                    
                    if error != nil {
                        
                        println(error)
                    }
                })
            }
        })
        
        endpoint.setIncomingCallBlock { (account, call) in
            
            print("\n\nIncoming Call : \(call.callId)\n\n")
        }
        
        endpoint.setAccountStateChangeBlock { (account) in
        
            print("\n\nAccount State : \(account.accountState.rawValue)\n\n")
        }
        
        endpoint.setCallStateChangeBlock { (account, call) in
            
            print("\n\nCall State : \(call.callState.rawValue)\n\n")
        }
        
        endpoint.setCallMediaStateChangeBlock { (account, call) in
            
            print("\n\nMedia State Changed\n\n")
        }
    }
    
    func addSipAccount() {
        
        let account = SWAccount()
        
        let configuration = SWAccountConfiguration()
        configuration.username = "getonsip_swig";
        configuration.password = "ggV4CUoHmXa9BaXG";
        configuration.domain = "getonsip.com";
        configuration.address = SWAccountConfiguration.addressFromUsername("swig", domain: configuration.domain);
        configuration.proxy = "sip.onsip.com";
        configuration.registerOnAdd = true;
        
        account.configure(configuration, completionHandler: { (error) in
    
            if error != nil {
                
                println(error)
            }
        })
    }
    
}

