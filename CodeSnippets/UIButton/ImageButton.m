//
//  ImageButton.m
//  CodeSnippets
//
//  Created by GeekRRK on 16/9/7.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

/*
 Refer to: http://www.cocoachina.com/ios/20160907/17499.html
 */

#import "ImageButton.h"

@implementation ImageButton

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect imageRect = self.frame;
    CGFloat imageW = 25;
    imageRect.size = CGSizeMake(imageW, imageW);
    imageRect.origin.x = (self.frame.size.width - imageW) * 0.5;
    imageRect.origin.y = (self.frame.size.height - imageW) * 0.5;
    self.imageView.frame = imageRect;
    
    CGRect titleRect = self.titleLabel.frame;
    
    titleRect.origin.x = (self.frame.size.width - titleRect.size.width) * 0.5;
    titleRect.origin.y = (self.frame.size.height - titleRect.size.height) * 0.5;
    self.titleLabel.frame = titleRect;
}

- (void)anotherWayInParentView {
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(50, 100, 80, 40);
    [btn1 setImage:[UIImage imageNamed:@"icon_shouye"] forState:UIControlStateNormal];
    [btn1 setTitle:@"首页" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor redColor];    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, 50, 80, 40);
    [btn setImage:[UIImage imageNamed:@"icon_shouye"] forState:UIControlStateNormal];
    [btn setTitle:@"首页" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];    //上左下右
    
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, btn.frame.size.width - btn.imageView.frame.origin.x - btn.imageView.frame.size.width, 0, 0);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -(btn.frame.size.width - btn.imageView.frame.size.width ), 0, 0);
//    [self.view addSubview:btn1];
//    [self.view addSubview:btn];
}

@end
