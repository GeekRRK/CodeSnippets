//
//  UIView+ResponderChain.m
//  CodeSnippets
//
//  Created by GeekRRK on 1/20/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "UIView+ResponderChain.h"
#import <objc/runtime.h>

@implementation UIView (ResponderChain)

+ (void)load {
    Method origin = class_getInstanceMethod([UIView class], @selector(touchesBegan:withEvent:));
    Method custom = class_getInstanceMethod([UIView class], @selector(lxd_touchesBegan:withEvent:));
    method_exchangeImplementations(origin, custom);
    
    origin = class_getInstanceMethod([UIView class], @selector(touchesMoved:withEvent:));
    custom = class_getInstanceMethod([UIView class], @selector(lxd_touchesMoved:withEvent:));
    method_exchangeImplementations(origin, custom);
    
    origin = class_getInstanceMethod([UIView class], @selector(touchesEnded:withEvent:));
    custom = class_getInstanceMethod([UIView class], @selector(lxd_touchesEnded:withEvent:));
    method_exchangeImplementations(origin, custom);
    
    origin = class_getInstanceMethod([UIView class], @selector(hitTest:withEvent:));
    custom = class_getInstanceMethod([UIView class], @selector(lxd_hitTest:withEvent:));
    method_exchangeImplementations(origin, custom);
    
    origin = class_getInstanceMethod([UIView class], @selector(pointInside:withEvent:));
    custom = class_getInstanceMethod([UIView class], @selector(lxd_pointInside:withEvent:));
    method_exchangeImplementations(origin, custom);
}

- (void)lxd_touchesBegan: (NSSet *)touches withEvent: (UIEvent *)event
{
    NSLog(@"%@ --- begin", self.class);
//    [self lxd_touchesBegan: touches withEvent: event];
    
    UIResponder *next = [self nextResponder];
    NSMutableString *prefix = @"".mutableCopy;
    
    while (next != nil) {
        NSLog(@"%@%@", prefix, [next class]);
        [prefix appendString: @"--"];
        next = [next nextResponder];
    }
}

- (void)lxd_touchesMoved: (NSSet *)touches withEvent: (UIEvent *)event
{
    NSLog(@"%@ --- move", self.class);
//    [self lxd_touchesMoved: touches withEvent: event];
}

- (void)lxd_touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event
{
    NSLog(@"%@ --- end", self.class);
//    [self lxd_touchesEnded: touches withEvent: event];
}

- (nullable UIView *)lxd_hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event {
    NSLog(@"hit view: %@", self.class);
    
    return self;
}

- (BOOL)lxd_pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event {
    BOOL res = CGRectContainsPoint(self.bounds, point);
    NSLog(@"%@ can answer %@", self.class, res ? @"1" : @"0");
    
    return res;
}

@end
