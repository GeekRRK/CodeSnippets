//
//  DelaysContentTouchesTableView.m
//  CodeSnippets
//
//  Created by GeekRRK on 1/8/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "DelaysContentTouchesTableView.h"

@implementation DelaysContentTouchesTableView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.delaysContentTouches = NO;
    }
    
    // iterate over all the UITableView's subviews
    for (id view in self.subviews)
    {
        // looking for a UITableViewWrapperView
        if ([NSStringFromClass([view class])
             isEqualToString:@"UITableViewWrapperView"])
        {
            // this test is necessary for safety and because a
            // "UITableViewWrapperView" is NOT a UIScrollView in iOS7
            if([view isKindOfClass:[UIScrollView class]])
            {
                // turn OFF delaysContentTouches in the hidden subview
                UIScrollView *scroll = (UIScrollView *)view;
                scroll.delaysContentTouches = NO;
            }
            break;
        }
    }
    
    return self;
}

// default returns YES if view isn't a UIControl
// Returns whether to cancel touches related to
// the content subview and start dragging.
- (BOOL)touchesShouldCancelInContentView:(UIView *)view{
    if ([view isKindOfClass:[UIButton class]])
    {
        return YES;
    }
    return [super touchesShouldCancelInContentView:view];
}

@end
