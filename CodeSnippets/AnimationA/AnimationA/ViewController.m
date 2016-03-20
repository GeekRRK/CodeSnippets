//
//  ViewController.m
//  AnimationA
//
//  Created by Geek on 16-3-20.
//  Copyright (c) 2016年 GeekRRK. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view2.alpha = 0;
    self.view3.alpha = 0;
    [UIView animateWithDuration:5 delay:0.5 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionRepeat animations:^{
        CGPoint point = self.view1.center;
        point.y += 100;
        self.view1.center = point;
    } completion:^(BOOL finished) {
        NSLog(@"view1 finish");
    }];
    
    [UIView animateWithDuration:5 delay:0.5 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionRepeat animations:^{
        self.view2.alpha = 1;
    } completion:^(BOOL finished) {
        NSLog(@"view2 finish");
    }];
    
    [UIView animateWithDuration:5 delay:0.5 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionRepeat animations:^{
        CGPoint point = self.view3.center;
        point.y -= 100;
        self.view3.center = point;
        self.view3.alpha = 1;
    } completion:^(BOOL finished) {
        NSLog(@"view3 finish");
    }];
    
    [UIView transitionWithView:self.view4 duration:0.5 options:UIViewAnimationOptionTransitionCurlDown | UIViewAnimationCurveEaseOut animations:^{
        self.view4.hidden = NO;
    } completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
