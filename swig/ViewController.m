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

@property (nonatomic, strong) SWCall *currentCall;

@end

@implementation ViewController
            
-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    SWAccount *account = [[SWEndpoint sharedInstance] lookupAccount:0];
    
    [account setStateChangeBlock:^(SWAccountState state) {
        self.statusLabel.text = [NSString stringWithFormat:@"%d", state];
    }];
    
    [account setIncomingCallBlock:^(SWCall *call) {
        
        if (self.currentCall) {
            
            [self.currentCall hangup:^(NSError *error) {
                self.currentCall = call;
            }];
        }
        
        else {
            self.currentCall = call;
        }
    }];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)makeCall:(id)sender {
    
    SWAccount *account = [[SWEndpoint sharedInstance] lookupAccount:0];
    
    if (self.currentCall) {
        
        [self.currentCall hangup:^(NSError *error) {
            
            self.currentCall = [SWCall callFromAccount:account];
            
            [self.currentCall makeCall:@"6474785132" completionHandler:^(NSError *error) {
                
            }];
        }];
    }
    
    else {
        
        self.currentCall = [SWCall callFromAccount:account];
        
        [self.currentCall makeCall:@"6474785132" completionHandler:^(NSError *error) {
            
        }];
    }
}

-(IBAction)answer:(id)sender {
    
    [self.currentCall answer:^(NSError *error) {
        
    }];
}

-(IBAction)hangup:(id)sender {
    
    [self.currentCall hangup:^(NSError *error) {
        
    }];
}

@end
