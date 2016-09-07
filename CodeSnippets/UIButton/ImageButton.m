//
//  ImageButton.m
//  CodeSnippets
//
//  Created by UGOMEDIA on 16/9/7.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "ImageButton.h"

@implementation ImageButton

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect imageRect = self.imageView.frame;
    imageRect.size = CGSizeMake(30, 30);
    imageRect.origin.x = (self.frame.size.width - 30) ;
    imageRect.origin.y = (self.frame.size.height  - 30)/2.0f;
    CGRect titleRect = self.titleLabel.frame;
    titleRect.origin.x = (self.frame.size.width - imageRect.size.width- titleRect.size.width);
    titleRect.origin.y = (self.frame.size.height - titleRect.size.height)/2.0f;
    self.imageView.frame = imageRect;
    self.titleLabel.frame = titleRect;
}

@end
