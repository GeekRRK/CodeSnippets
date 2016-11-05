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

+ (void)request:(NSString *)api param:(NSDictionary *)param success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    NSURL *URL = [NSURL URLWithString:api];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"POST"];
    NSString *paramURL = [AFInterface convertParam2URL:param];
    NSData *paramData = [paramURL dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
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

+ (void)request2UploadFile:(NSString *)api files:(NSDictionary *)files param:(NSDictionary *)param success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:api parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSArray *sortedFileKeys = [files.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        for (int i = 0; i < files.count; ++i) {
            NSString *key = sortedFileKeys[i];
            NSString *value = files[key];
            
            NSString *fileName = [value lastPathComponent];
            NSString *extension = [fileName pathExtension];
            
            NSString *mineType = @"";
            if ([extension isEqualToString:@".jpg"]) {
                mineType = @"image/jpeg";
            } else if ([extension isEqualToString:@".png"]) {
                mineType = @"image/png";
            }
            
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:value] name:key fileName:fileName mimeType:mineType error:nil];
        }
        
        NSArray *sortedParamKeys = [param.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        for (int i = 0; i < param.count; ++i) {
            NSString *key = sortedParamKeys[i];
            NSString *value = param[key];
            
            [formData appendPartWithFormData:[value dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES] name:key];
        }
    } error:nil];
    
    NSURLSessionUploadTask *uploadTask = [[AFInterface shareURLSessionMgr] uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failureBlock(error);
        } else {
            successBlock(responseObject);
        }
    }];
    [uploadTask resume];
}

+ (NSString *)convertParam2URL:(NSDictionary *)param {
    NSString *urlStr = @"";
    
    NSArray *sortedKyes = [param.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    for (int i = 0; i < sortedKyes.count; ++i) {
        NSString *key = sortedKyes[i];
        if ([param[key] isEqualToString:@""]) {
            continue;
        }
        
        NSString *value = param[key];
        NSString *encodedValue = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                       NULL,
                                                                                                       (CFStringRef)value,
                                                                                                       NULL,
                                                                                                       (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                       kCFStringEncodingUTF8 ));
        
        urlStr = [NSString stringWithFormat:@"%@&%@=%@", urlStr, key, encodedValue];
    }
    
    urlStr = [urlStr stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"&"]];
    
    return urlStr;
}

@end
