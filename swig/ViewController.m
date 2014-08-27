//
//  ViewController.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "ViewController.h"
#import "Swig.h"

@interface ViewController ()

//@property (nonatomic, weak) SWCall *currentCall;

@end

@implementation ViewController
            
-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)makeCall:(id)sender {
    
    SWAccount *account = [[SWEndpoint sharedEndpoint] lookupAccount:0];
    
    [account makeCall:@"6474785132" completionHandler:^(NSError *error) {
       
        DDLogDebug(@"%@", [error description]);
    }];
}

-(IBAction)answer:(id)sender {
    
//    [self.currentCall answer:^(NSError *error) {
//        
//    }];
}

-(IBAction)hangup:(id)sender {
    
//    [self.currentCall hangup:^(NSError *error) {
//        
//    }];
}

@end
