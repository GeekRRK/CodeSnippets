//
//  ImageButton.m
//  CodeSnippets
//
//  Created by UGOMEDIA on 16/9/7.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

/*
 Refer to: http://www.cocoachina.com/ios/20160907/17499.html
 */

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
