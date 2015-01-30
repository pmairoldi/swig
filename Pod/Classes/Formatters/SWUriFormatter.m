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
    
    //TODO rewrite this. it is overly complex
    
    if ([uri length] == 0) {
        return [[SWContact alloc] initWithName:nil address:nil];
    }
    
    NSCharacterSet *spaceSet = [NSCharacterSet characterSetWithCharactersInString:@" "];
    
    uri = [uri stringByTrimmingCharactersInSet:spaceSet];
    
    if ([uri rangeOfString:@"\"<"].location != NSNotFound && [uri rangeOfString:@">\""].location != NSNotFound) {
        
        NSRange leftBraceOriginal = [uri rangeOfString:@"\"<"];
        
        if (leftBraceOriginal.location != NSNotFound) {
            uri = [uri stringByReplacingCharactersInRange:leftBraceOriginal withString:@"\""];
        }
        
        NSRange rightBraceOriginal = [uri rangeOfString:@">\""];
        
        if (rightBraceOriginal.location != NSNotFound) {
            uri = [uri stringByReplacingCharactersInRange:rightBraceOriginal withString:@"\""];
        }
    }

    if ([uri rangeOfString:@"<"].location == NSNotFound && [uri rangeOfString:@">"].location == NSNotFound) {
        
        return [[SWContact alloc] initWithName:nil address:[[uri stringByReplacingOccurrencesOfString:@"sip:" withString:@""] stringByReplacingOccurrencesOfString:@"\"" withString:@""]];
    }
    
    NSRange nameRange;
    NSUInteger addressLocation;
    
    if ([uri rangeOfString:@"<sip:"].location != NSNotFound) {
        
        nameRange = NSMakeRange(0, [uri rangeOfString:@"<sip:"].location);
        addressLocation = [uri rangeOfString:@"<sip:"].location + [uri rangeOfString:@"<sip:"].length;
    }
    
    else {
        
        nameRange =  NSMakeRange(0, [uri rangeOfString:@"<"].location);
        addressLocation = [uri rangeOfString:@"<"].location + [uri rangeOfString:@"<"].length;
    }
    
    NSString *name = [[uri substringWithRange:nameRange] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    
    NSRange addressRange = NSMakeRange(addressLocation, [uri rangeOfString:@">"].location - addressLocation);
    
    NSString *address = [uri substringWithRange:addressRange];
    
    return [[SWContact alloc] initWithName:[name stringByTrimmingCharactersInSet:spaceSet] address:[address stringByTrimmingCharactersInSet:spaceSet]];
}

@end
