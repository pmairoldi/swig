//
//  SWViewController.m
//  Swig
//
//  Created by Pierre-Marc Airoldi on 09/01/2014.
//  Copyright (c) 2014 Pierre-Marc Airoldi. All rights reserved.
//

#import "SWViewController.h"
#import <Swig/Swig.h>

@interface SWViewController ()

@end

@implementation SWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)makeCall:(id)sender {
 
    SWAccount *account = [[SWEndpoint sharedEndpoint] firstAccount];
    
    [account makeCall:@"swig_2@getonsip.com" completionHandler:^(NSError *error) {
       
        if (error) {
            NSLog(@"%@",[error description]);
        }
    }];
}

-(IBAction)answer:(id)sender {
    
    SWAccount *account = [[SWEndpoint sharedEndpoint] firstAccount];

    SWCall *call = [account firstCall];
    
    if (call) {
        [call answer:^(NSError *error) {
            
        }];
    }
}

-(IBAction)mute:(id)sender {
    
    SWAccount *account = [[SWEndpoint sharedEndpoint] firstAccount];
    
    SWCall *call = [account firstCall];

    if (call) {
        
        [call toggleMute:^(NSError *error) {

        }];
    }
}

-(IBAction)speaker:(id)sender {
    
    SWAccount *account = [[SWEndpoint sharedEndpoint] firstAccount];
    
    SWCall *call = [account firstCall];
    
    if (call) {
        
        [call toggleSpeaker:^(NSError *error) {

        }];
    }
}

@end
