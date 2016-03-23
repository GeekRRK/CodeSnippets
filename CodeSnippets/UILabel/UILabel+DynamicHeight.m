//
//  UILabel+DynamicHeight.m
//  CodeSnippets
//
//  Created by UGOMEDIA on 16/3/23.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "UILabel+DynamicHeight.h"

@implementation UILabel (DynamicHeight)

- (float)resizeToFitHeight{
    float height = [self expectedHeight];
    CGRect newFrame = [self frame];
    newFrame.size.height = height;
    [self setFrame:newFrame];
    
    return newFrame.origin.y + newFrame.size.height;
}

- (float)expectedHeight{
    [self setNumberOfLines:0];
    [self setLineBreakMode:NSLineBreakByWordWrapping];
    
    CGSize maximumLabelSize = CGSizeMake(self.frame.size.width, 9999);
    
    CGSize expectedLabelSize = [[self text] sizeWithFont:[self font]
                                       constrainedToSize:maximumLabelSize
                                           lineBreakMode:[self lineBreakMode]];
    
    return expectedLabelSize.height;
}

@end
