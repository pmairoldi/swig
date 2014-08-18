//
//  SWCall.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-18.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWCall.h"
#import "SWAccount.h"
#import "SwigCall.h"
#import "NSError+Error.h"
#import "NSString+String.h"
#import "SWCallOpParam.h"

@interface SWCall ()

@property sw::Call *call;

@end

@implementation SWCall

-(instancetype)init {
    
    return nil;
}

-(instancetype)initWithCallId:(NSInteger)callId account:(SWAccount *)calledAccount {
    
    self = [super init];
    
    if (!self) {
        return self;
    }
    
    _call = new sw::Call(*calledAccount.swigAccount, callId);
    
    return self;
}

+(instancetype)callWithId:(NSInteger)callId account:(SWAccount *)calledAccount {
    
    return [[SWCall alloc] initWithCallId:callId account:calledAccount];
}

+(instancetype)callFromAccount:(SWAccount *)calledAccount {
    
    return [[SWCall alloc] initWithCallId:PJSUA_INVALID_ID account:calledAccount];
}

-(NSInteger)getId {
    
    return self.call->getId();
}

-(void)makeCall:(NSString *)destinationUri callOpParams:(SWCallOpParam *)param success:(void (^)())success failure:(void (^)(NSError *error))failure {
        
    if (!param) {
        param = [SWCallOpParam defaultSettings];
    }

    NSError *error;
    
    try {
        self.call->makeCall(*[destinationUri CPPString], param.callOpParam);
    } catch(pj::Error& err) {
        error = [NSError errorWithError:&err];
    }
    
    if (error) {
        if (failure) {
            failure(error);
        }
    }
    
    else {
        if (success) {
            success();
        }
    }

}

@end
