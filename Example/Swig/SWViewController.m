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
 
    SWAccount *account = [[SWEndpoint sharedEndpoint] lookupAccount:0];
    
    [account makeCall:@"trac@getonsip.com" completionHandler:^(NSError *error) {
       
        if (error) {
            NSLog(@"%@",[error description]);
        }
    }];
}

@end
