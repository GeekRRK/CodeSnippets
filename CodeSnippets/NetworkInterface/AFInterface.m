//
//  AFInterface.m
//  CodeSnippets
//
//  Created by GeekRRK on 16/8/11.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "AFInterface.h"

@implementation AFInterface

+ (AFURLSessionManager *)shareURLSessionMgr {
    static AFURLSessionManager *URLSessionMgr;
    static dispatch_once_t onecToken;
    dispatch_once(&onecToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        URLSessionMgr = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    });
    
    return URLSessionMgr;
}

+ (void)request:(NSString *)urlStr param:(NSDictionary *)paramDict orderedKeyArr:(NSArray *)orderedKeyArr success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    NSURL *URL = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"POST"];
    NSString *paramStr = [AFInterface convertDict2UrlStr:paramDict orderedKeyArr:(NSArray *)orderedKeyArr];
    NSData *paramData = [paramStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [request setHTTPBody:paramData];
    
    [AFInterface shareURLSessionMgr].responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionDataTask *dataTask = [[AFInterface shareURLSessionMgr] dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failureBlock(error);
        } else {
            successBlock(responseObject);
        }
    }];
    [dataTask resume];
}

+ (void)request2UploadFile:(NSString *)urlStr filePath:(NSString *)path param:(NSDictionary *)paramDict success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (id key in paramDict) {
            [formData appendPartWithFormData:[paramDict[key] dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES] name:key];
        }
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:path] name:@"image" fileName:@"avatar.jpg" mimeType:@"image/jpeg" error:nil];
    } error:nil];
    
    NSURLSessionUploadTask *uploadTask = [[AFInterface shareURLSessionMgr] uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failureBlock(error);
        } else {
            successBlock(responseObject);
        }
    }];
    [uploadTask resume];
}

+ (void)request2UploadFile:(NSString *)urlStr filePathArr:(NSMutableArray *)pathArr param:(NSDictionary *)paramDict success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (id key in paramDict) {
            [formData appendPartWithFormData:[paramDict[key] dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES] name:key];
        }
        
        for (int i = 0; i < pathArr.count; ++i) {
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:pathArr[i]] name:@"image" fileName:@"avatar.jpg" mimeType:@"image/jpeg" error:nil];
        }
    } error:nil];
    
    NSURLSessionUploadTask *uploadTask = [[AFInterface shareURLSessionMgr] uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failureBlock(error);
        } else {
            successBlock(responseObject);
        }
    }];
    [uploadTask resume];
}

+ (NSString *)convertDict2UrlStr:(NSDictionary *)dict orderedKeyArr:(NSArray *)orderedKeyArr{
    NSString *md5Str = @"";
    
    NSString *urlStr = @"";
    for (int i = 0; i < orderedKeyArr.count; ++i) {
        NSString *key = orderedKeyArr[i];
        if ([dict[key] isEqualToString:@""]) {
            continue;
        }
        
        urlStr = [NSString stringWithFormat:@"%@&%@=%@", urlStr, key, dict[key]];
        
        md5Str = [md5Str stringByAppendingString:dict[key]];
    }
    
    urlStr = [urlStr substringFromIndex:1];
    
    return urlStr;
}

+ (NSMutableDictionary *)convertUrlStr2Dict:(NSString *)urlStr {
    NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc] init];
    NSArray *keyValueArr = [urlStr componentsSeparatedByString:@"&"];
    for (int i = 0; i < keyValueArr.count; ++i) {
        NSArray *pairArr = [keyValueArr[i] componentsSeparatedByString:@"="];
        [mutableDict setObject:pairArr[1] forKey:pairArr[0]];
    }
    
    return mutableDict;
}

@end
