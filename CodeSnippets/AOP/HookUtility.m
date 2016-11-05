//
//  HookUtility.m
//  Demo_Indicator
//
//  Created by GeekRRK on 16/4/22.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "HookUtility.h"
#import <objc/runtime.h>

@implementation HookUtility

+ (void)swizzlingInClass:(Class)class originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (NSDictionary *)dictionaryFromUserStatisticsConfigPlist {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"GlobalUserStatisticConfig" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    return dic;
}

@end
