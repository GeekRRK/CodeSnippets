//
//  CALayerViewController.m
//  CodeSnippets
//
//  Created by GeekRRK on 1/14/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "CALayerViewController.h"

@interface CALayerViewController ()

@end

@implementation CALayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configureLayer];
}

- (void)configureLayer {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:view];
    
    view.layer.borderWidth = 5;
    view.layer.borderColor = [UIColor greenColor].CGColor;
    view.layer.cornerRadius = 20;
    view.layer.contents = (id)[UIImage imageNamed:@"contentsimg.jpg"].CGImage;
    view.layer.masksToBounds = YES;
    
    UIView *shadow = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [shadow addSubview:view];
    [self.view addSubview:shadow];
    shadow.layer.shadowColor = [UIColor blackColor].CGColor;
    shadow.layer.shadowOffset = CGSizeMake(10, 10);
    shadow.layer.shadowOpacity = 0.6;
    shadow.layer.shadowRadius = 5;
    shadow.clipsToBounds = NO;
    
    shadow.transform = CGAffineTransformMakeTranslation(0, -100);
    shadow.layer.transform = CATransform3DMakeTranslation(100, 20, 0);
    
    NSValue *v =
    [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(100, 20, 0)];
    [shadow.layer setValue:v forKeyPath:@"transform"];
    
    [shadow.layer setValue:@(-100) forKeyPath:@"transform.translation.x"];
    
    shadow.layer.transform = CATransform3DMakeRotation(M_PI_4, 1, 1, 0.5);
}

@end
