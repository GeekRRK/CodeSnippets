//
//  UIViewController+InjectStatisticMaiDian.m
//  Demo_Indicator
//
//  Created by GeekRRK on 16/4/22.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "UIViewController+InjectStatisticMaiDian.h"
#import "HookUtility.h"

@implementation UIViewController (InjectStatisticMaiDian)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(swiz_viewWillAppear:);
        [HookUtility swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
        
        SEL orignalDisappearSelector = @selector(viewWillDisappear:);
        SEL swizzledDisappearSelector = @selector(swiz_viewWillDisappear:);
        [HookUtility swizzlingInClass:[self class] originalSelector:orignalDisappearSelector swizzledSelector:swizzledDisappearSelector];
    });
}

- (void)swiz_viewWillAppear:(BOOL)animated {
    [self inject_viewWillAppear];
    [self swiz_viewWillAppear:animated];
}

- (void)swiz_viewWillDisappear:(BOOL)animated {
    [self inject_viewWillDisappear];
    [self swiz_viewWillDisappear:animated];
}

- (void)inject_viewWillAppear {
    NSString *pageID = [self pageEventID:YES];
    if (pageID) {
        NSLog(@"%@", pageID);
    }
}

- (void)inject_viewWillDisappear {
    NSString *pageID = [self pageEventID:NO];
    if (pageID) {
        NSLog(@"%@", pageID);
    }
}

- (NSString *)pageEventID:(BOOL)bEnterPage {
    NSDictionary *configDict = [HookUtility dictionaryFromUserStatisticsConfigPlist];
    NSString *selfClassName = NSStringFromClass([self class]);
    
    return configDict[selfClassName][@"PageEventIDs"][bEnterPage ? @"Enter" : @"Leave"];
}

@end
