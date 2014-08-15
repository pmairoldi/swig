//
//  SWAccount.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-14.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWAccount.h"
#import "SwigAccount.h"

@interface SWAccount ()

@end

@implementation SWAccount

-(instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    AccountConfig acc_cfg;
    acc_cfg.idUri = "sip:mobila@getonsip.com";
    acc_cfg.regConfig.registrarUri = "sip:getonsip.com";
    acc_cfg.sipConfig.authCreds.push_back( AuthCredInfo("digest", "*", "getonsip_mobila", 0, "NQFxmwxw4wQMEfp3") );
    acc_cfg.sipConfig.proxies.push_back("sip:sip.onsip.com");
    
    SwigAccount *acc = new SwigAccount;
    try {
        acc->create(acc_cfg);
    } catch(Error& err) {
//        cout << "Account creation error: " << err.info() << endl;
    }
    
    return self;
}

+(SWAccount *)accountForId:(NSInteger)accountId {
    
    // pj::Account::lookup(accountId)
    return [SWAccount new];
}

@end
