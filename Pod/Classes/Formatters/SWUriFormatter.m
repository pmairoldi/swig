//
//  SWUriFormatter.m
//  swig
//
//  Created by Pierre-Marc Airoldi on 2014-08-21.
//  Copyright (c) 2014 PeteAppDesigns. All rights reserved.
//

#import "SWUriFormatter.h"
//#import "Swig.h"
#import "SWContact.h"
#import "SWAccount.h"
#import "SWAccountConfiguration.h"

@implementation SWUriFormatter

+(NSString *)sipUri:(NSString *)uri {
    
    NSString *sipUri = uri;
    
    if (![sipUri hasPrefix:@"sip:"]) {
        sipUri = [NSString stringWithFormat:@"sip:%@", sipUri];
    }
    
    return sipUri;
}

+(NSString *)sipUri:(NSString *)uri fromAccount:(SWAccount *)account {
    
    NSString *sipUri = [SWUriFormatter sipUri:uri];
    
    if ([sipUri rangeOfString:@"@"].location == NSNotFound) {
        sipUri = [NSString stringWithFormat:@"%@@%@", sipUri, account.accountConfiguration.domain];
    }
    
    if (![sipUri hasSuffix:account.accountConfiguration.domain]) {
        
        sipUri = [sipUri stringByPaddingToLength:[sipUri rangeOfString:@"@"].location withString:@"" startingAtIndex:0];
        sipUri = [NSString stringWithFormat:@"%@@%@", sipUri, account.accountConfiguration.domain];
    }
    
    return sipUri;
}


+(NSString *)sipUri:(NSString *)uri withDisplayName:(NSString *)displayName {
    
    NSString *sipUri = uri;
    
    if (![sipUri hasPrefix:@"sip:"]) {
        sipUri = [NSString stringWithFormat:@"sip:%@", sipUri];
    }
    
    if (displayName) {
        sipUri = [NSString stringWithFormat:@"\"%@\" <%@>", displayName, sipUri];
    }
    
    return sipUri;
}

+(SWContact *)contactFromURI:(NSString *)uri {
    
    NSRange nameRange;
    
    if ([uri rangeOfString:@" <"].location != NSNotFound) {
        
        nameRange = NSMakeRange(0, [uri rangeOfString:@" <"].location);
    }
    
    else {
        
        nameRange =  NSMakeRange(0, [uri rangeOfString:@"<"].location);
    }
    
    
    NSString *name = [[uri substringWithRange:nameRange] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    
    NSUInteger addressLocation = [uri rangeOfString:@"<sip:"].location + [uri rangeOfString:@"<sip:"].length;
    
    NSRange addressRange = NSMakeRange(addressLocation, [uri rangeOfString:@">"].location - addressLocation);
    
    NSString *address = [uri substringWithRange:addressRange];
    
    return [[SWContact alloc] initWithName:name address:address];
}

@end
