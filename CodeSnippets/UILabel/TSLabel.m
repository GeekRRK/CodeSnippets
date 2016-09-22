//
//  TSLabel.m
//  CodeSnippets
//
//  Created by GeekRRK on 16/8/9.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "TSLabel.h"

@implementation TSLabel

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    if ( self.numberOfLines == 0 )
    {
        if ( self.preferredMaxLayoutWidth != self.frame.size.width )
        {
            self.preferredMaxLayoutWidth = self.frame.size.width;
            [self setNeedsUpdateConstraints];
        }
    }
}

- (CGSize) intrinsicContentSize
{
    CGSize s = [super intrinsicContentSize];
    
    if ( self.numberOfLines == 0 )
    {
        // found out that sometimes intrinsicContentSize is 1pt too short!
        s.height += 1;
    }
    
    return s;
}

@end
