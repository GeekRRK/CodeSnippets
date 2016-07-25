#import <AFURLSessionManager.h>

typedef void (^SuccessBlock)(NSDictionary *responseObject);
typedef void (^FailureBlock)(NSError *error);

#define __GEEKDEBUG__
#ifndef __GEEKDEBUG__
    #define SERVERADDR @""
#else
    #define SERVERADDR @""
#endif


#pragma mark - ThirdParty

#pragma mark - Login

#pragma mark - Notification

#pragma mark - API

@interface NXHInterface : NSObject

+ (void)request:(NSString *)urlStr param:(NSDictionary *)param success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;
+ (void)request2UploadFile:(NSString *)urlStr filePath:(NSString *)path param:(NSDictionary *)paramDict success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

@end
