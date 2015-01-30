//
//  ViewController.swift
//  Swig-Swift
//
//  Created by Pierre-Marc Airoldi on 2015-01-29.
//  Copyright (c) 2015 Pierre-Marc Airoldi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction private func makeCall() {
        
        let account = SWEndpoint.sharedEndpoint().firstAccount()
        
        account.makeCall("swig_2@getonsip.com", completionHandler: { (error) in
            
            if error != nil {
                println(error)
            }
        })
    }
    
    @IBAction private func answer() {
        
        let account = SWEndpoint.sharedEndpoint().firstAccount()
        let call = account.firstCall()
        
        if call != nil {
           
            call.answer({ (error) in
                
                if error != nil {
                    println(error)
                }
            })
        }
    }
    
    @IBAction private func mute() {
        
        let account = SWEndpoint.sharedEndpoint().firstAccount()
        let call = account.firstCall()
        
        if call != nil {
            
            call.toggleMute({ (error) in
                
                if error != nil {
                    println(error)
                }
            })
        }
    }
    
    @IBAction private func speaker() {
        
        let account = SWEndpoint.sharedEndpoint().firstAccount()
        let call = account.firstCall()
        
        if call != nil {
            
            call.toggleSpeaker({ (error) in
                
                if error != nil {
                    println(error)
                }
            })
        }
    }
}

