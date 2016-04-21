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

+ (void)postJson{
    NSURL *url = [NSURL URLWithString:@"www.baidu.com"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";

    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];

    NSDictionary *json = @{
                           @"orgId" : @"33",
                           @"identityToken" : @"27428ac78435c325bbff4dcdd3629c05"
                           };
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = data;
    [request setTimeoutInterval:20];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
                               
                               NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:NSJSONReadingAllowFragments
                                                                                      error:nil];
                               NSLog(@"%@", json);
                           }];
}

//The following code won't run because lack of AFNetworking

//+ (AFHTTPSessionManager *)shareSessionManager {
//    static AFHTTPSessionManager *manager;
//    static dispatch_once_t temp;
//    dispatch_once(&temp, ^{
//        manager = [[AFHTTPSessionManager alloc] init];
//        manager.requestSerializer.timeoutInterval = 20;
//    });
//    
//    return manager;
//}
//
//+ (void)postRequest {
//    [[NetworkInterface shareSessionManager] POST:apiUrl parameters:dictRequest progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"Success --- %@", responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"Failure --- %@", error.localizedDescription);
//    }];
//}

@end
