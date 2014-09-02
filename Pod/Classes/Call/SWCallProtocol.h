//
//  SWCallProtocol.h
//  Pods
//
//  Created by Pierre-Marc Airoldi on 2014-09-02.
//
//

#import <Foundation/Foundation.h>

@protocol SWCallProtocol <NSObject>

-(void)callStateChanged;
-(void)mediaStateChanged;

@end
