//
//  NetworkInterface.m
//  CodeSnippets
//
//  Created by UGOMEDIA on 16/4/19.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "NetworkInterface.h"

@implementation NetworkInterface

+ (NSString *)generatePostStringWithDictionaryBlank:(NSDictionary *)dict{
    __block NSString *postString = @"";
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
        BOOL isFiltered = NO;
        if(obj != nil){
            if(([obj isKindOfClass:[NSString class]])){
                if((obj == nil) || ([obj isEqualToString:@""])){
                    isFiltered = YES;
                }
            }
            
            if(isFiltered == NO){
                NSString *param = [[NSString alloc] initWithFormat:@"&%@=%@", key, obj];
                postString = [postString stringByAppendingString:param];
            }
        }
    }];
    
    return [postString substringFromIndex:1];
}

+ (NSDictionary *)postString:(NSString *)dataAsString to:(NSString *)urlAsString{
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:360.0];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[dataAsString length]];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [dataAsString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *jsonAsData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil  error:nil];
    NSDictionary *dict;
    
    if(jsonAsData != nil){
        dict = [NSJSONSerialization JSONObjectWithData:jsonAsData options:NSJSONReadingAllowFragments error:nil];
        return dict;
    }
    
    return nil;
}

@end
