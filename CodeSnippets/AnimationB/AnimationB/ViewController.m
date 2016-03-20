//
//  ViewController.m
//  AnimationB
//
//  Created by Geek on 16-3-20.
//  Copyright (c) 2016年 GeekRRK. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) CALayer *myLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CALayer *myLayler = [CALayer layer];
    
    myLayler.bounds = CGRectMake(0, 0, 50, 80);
    myLayler.backgroundColor = [UIColor yellowColor].CGColor;
    myLayler.position = CGPointMake(50, 50);
    myLayler.anchorPoint = CGPointMake(0, 0);
    myLayler.cornerRadius = 20;
    
    [self.view.layer addSublayer:myLayler];
    self.myLayer = myLayler;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    CABasicAnimation *animation = [CABasicAnimation animation];
//    animation.keyPath = @"position";
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
//    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
//    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 300)];
    animation.duration = 2.0;
//    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
//    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2 + M_PI_4, 1, 1, 0)];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 100, 1)];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    animation.delegate = self;
    NSString *str = NSStringFromCGPoint(self.myLayer.position);
    NSLog(@"Animation before: %@", str);
    
    [self.myLayer addAnimation:animation forKey:nil];
}

- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"Animation start");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSString *str = NSStringFromCGPoint(self.myLayer.position);
    NSLog(@"Animation stop: %@", str);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
