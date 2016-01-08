//
//  UIImageViewMode.m
//  CodeSnippets
//
//  Created by GeekRRK on 1/8/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "UIImageViewModeViewController.h"

@interface UIImageViewModeViewController ()

@end

@implementation UIImageViewModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)configureImageView{
    UIImage *pic = [ UIImage imageNamed:@"uiimageviewmode.jpg"];
    UIImageView *imageView = [[UIImageView alloc]
                              initWithFrame:CGRectMake(20, 20, 240, 100)];
    [self.view addSubview:imageView];
    
    [imageView setImage:pic];
    [imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    imageView.clipsToBounds = YES;
}

@end
