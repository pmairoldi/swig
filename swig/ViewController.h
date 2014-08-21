//
//  ViewController.h
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property IBOutlet UILabel *statusLabel;

-(IBAction)makeCall:(id)sender;
-(IBAction)answer:(id)sender;
-(IBAction)hangup:(id)sender;

@end

