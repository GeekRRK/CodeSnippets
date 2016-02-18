//
//  CAShapeLayerViewController.m
//  CodeSnippets
//
//  Created by suorui on 2/18/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "CAShapeLayerViewController.h"

@interface CAShapeLayerViewController ()

@end

@implementation CAShapeLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self animatedCircle];
}

- (void)animatedCircle {
    CAShapeLayer *bottomShapeLayer = [CAShapeLayer layer];
    bottomShapeLayer.strokeColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1].CGColor;
    bottomShapeLayer.fillColor = [UIColor clearColor].CGColor;
    bottomShapeLayer.lineWidth = 2;
    bottomShapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 100, 40, 40) cornerRadius:5].CGPath;
    [self.view.layer addSublayer:bottomShapeLayer];
    
    CAShapeLayer *ovalShapeLayer = [CAShapeLayer layer];
    ovalShapeLayer.strokeColor = [UIColor colorWithRed:0.984 green:0.153 blue:0.039 alpha:1].CGColor;
    ovalShapeLayer.fillColor = [UIColor clearColor].CGColor;
    ovalShapeLayer.lineWidth = 2;
    ovalShapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 40, 40)].CGPath;
    [self.view.layer addSublayer:ovalShapeLayer];
    
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = @(-1);
    strokeStartAnimation.toValue = @(1.0);
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @(0.0);
    strokeEndAnimation.toValue = @(1.0);
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[strokeEndAnimation, strokeEndAnimation];
    animationGroup.duration = 2;
    animationGroup.repeatCount = CGFLOAT_MAX;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    [ovalShapeLayer addAnimation:animationGroup forKey:nil];
    ovalShapeLayer.lineDashPattern = @[@6, @3];
}

@end
