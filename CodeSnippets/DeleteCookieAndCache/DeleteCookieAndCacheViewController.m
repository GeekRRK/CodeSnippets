//
//  DeleteCookieAndCacheViewController.m
//  CodeSnippets
//
//  Created by suorui on 1/9/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "DeleteCookieAndCacheViewController.h"

@interface DeleteCookieAndCacheViewController ()

@end

@implementation DeleteCookieAndCacheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)deleteCookieAndCacheOfUIWebView {
    //delete cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage =
    [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
    
    //remove cache
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache *cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}

@end
