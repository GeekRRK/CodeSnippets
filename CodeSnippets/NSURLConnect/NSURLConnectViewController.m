//
//  NSURLConnectViewController.m
//  CodeSnippets
//
//  Created by GeekRRK on 1/11/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "NSURLConnectViewController.h"
#import <CommonCrypto/CommonDigest.h>

#define SERVER @"http://221.192.141.197:7001/httpInterface/accountInterface_signIn.action"

@interface NSURLConnectViewController ()

@end

@implementation NSURLConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *postString = [[NSString alloc] initWithFormat:
                            @"userName=%@"
                            "&password=%@"
                            "&identityToken=%@",
                            @"18603219123",
                            [self md5:@"11111111"],
                            @"27428ac78435c325bbff4dcdd3629c05"];
    [self postString:postString to:SERVER];
}

- (NSDictionary *)postString:(NSString *)dataAsString
                          to:(NSString *)urlAsString {
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    
    NSMutableURLRequest *request =
    [NSMutableURLRequest requestWithURL:url
                            cachePolicy:NSURLRequestUseProtocolCachePolicy
                        timeoutInterval:360.0];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",
                           (unsigned long)[dataAsString length]];
    [request addValue:@"application/x-www-form-urlencoded"
   forHTTPHeaderField:@"Content-Type"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [dataAsString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *jsonAsData = [NSURLConnection sendSynchronousRequest:request
                                               returningResponse:nil
                                                           error:nil];
    NSDictionary *dict;
    
    if(jsonAsData != nil){
        dict = [NSJSONSerialization JSONObjectWithData:jsonAsData
                                               options:NSJSONReadingAllowFragments
                                                 error:nil];
        return dict;
    }
    
    return nil;
}

- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    unsigned int len = (unsigned int)strlen(cStr);
    CC_MD5(cStr, len, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
