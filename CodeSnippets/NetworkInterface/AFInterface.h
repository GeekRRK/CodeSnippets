//
//  AFInterface.h
//  CodeSnippets
//
//  Created by GeekRRK on 16/8/11.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFURLSessionManager.h"

typedef void (^SuccessBlock)(NSDictionary *responseObject);
typedef void (^FailureBlock)(NSError *error);

#define __GEEKDEBUG__
#ifndef __GEEKDEBUG__
#define SERVERADDR @""
#else
#define SERVERADDR @""
#endif

@interface AFInterface : NSObject

+ (void)request:(NSString *)api param:(NSDictionary *)param success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

+ (void)request2UploadFile:(NSString *)api files:(NSDictionary *)files param:(NSDictionary *)param success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

@end
