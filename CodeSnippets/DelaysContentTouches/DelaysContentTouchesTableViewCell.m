//
//  DelaysContentTouchesTableViewCell.m
//  CodeSnippets
//
//  Created by GeekRRK on 1/8/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "DelaysContentTouchesTableViewCell.h"

@implementation DelaysContentTouchesTableViewCell

- (void)awakeFromNib {
    for (UIView *currentView in self.subviews) {
        NSString *className = NSStringFromClass([currentView class]);
        if([className isEqualToString:@"UITableViewCellScrollView"]) {
            UIScrollView *scroll = (UIScrollView *)currentView;
            [scroll setDelaysContentTouches:NO];
            break;
        }
    }
}

@end
