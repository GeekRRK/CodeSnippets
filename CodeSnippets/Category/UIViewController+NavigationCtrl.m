//
//  UIViewController+NavigationCtrl.m
//  CodeSnippets
//
//  Created by UGOMEDIA on 16/8/25.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "UIViewController+NavigationCtrl.h"

@implementation UIViewController (NavigationCtrl)

- (UINavigationController*)imy_navigationController {
    UINavigationController* nav = nil;
    if ([self isKindOfClass:[UINavigationController class]]) {
        nav = (id)self;
    } else {
        if ([self isKindOfClass:[UITabBarController class]]) {
            nav = [((UITabBarController*)self).selectedViewController imy_navigationController];
        } else {
            nav = self.navigationController;
        }
    }
    return nav;
}

@end
