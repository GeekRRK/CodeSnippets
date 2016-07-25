#import <AFNetworking.h>

@implementation NXHInterface

+ (AFURLSessionManager *)shareURLSessionMgr {
    static AFURLSessionManager *URLSessionMgr;
    static dispatch_once_t onecToken;
    dispatch_once(&onecToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        URLSessionMgr = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    });
    
    return URLSessionMgr;
}

+ (void)request:(NSString *)urlStr param:(NSDictionary *)paramDict success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    NSURL *URL = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"POST"];
    NSString *paramStr = [NXHInterface convertDict2UrlStr:paramDict];
    NSData *paramData = [paramStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [request setHTTPBody:paramData];
    
    NSURLSessionDataTask *dataTask = [[NXHInterface shareURLSessionMgr] dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
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
    
    NSURLSessionUploadTask *uploadTask = [[NXHInterface shareURLSessionMgr] uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failureBlock(error);
        } else {
            successBlock(responseObject);
        }
    }];
    [uploadTask resume];
}

+ (NSString *)convertDict2UrlStr:(NSDictionary *)dict {
    NSString *urlStr = @"";
    for (id key in dict) {
        if ([dict[key] isEqualToString:@""]) {
            continue;
        }
        
        urlStr = [NSString stringWithFormat:@"%@&%@=%@", urlStr, key, dict[key]];
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
