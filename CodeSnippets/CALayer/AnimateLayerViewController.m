//
//  ViewController.m
//  AutoLayout
//
//  Created by GeekRRK on 1/25/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "AnimateLayerViewController.h"
#import "KCView.h"

#define WIDTH 50
#define PHOTO_HEIGHT 150

@interface AnimateLayerViewController () {
    CALayer *animateLayer;
}

@end

@implementation AnimateLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addAnimateLayer];
}

- (void)addAnimateLayer {
    UIImage *backgroundImage = [UIImage imageNamed:@"calayer_background.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    animateLayer = [[CALayer alloc] init];
    animateLayer.bounds = CGRectMake(0, 0, 10, 20);
    animateLayer.position = CGPointMake(50, 150);
    animateLayer.anchorPoint = CGPointMake(0.5, 0.6);
    animateLayer.contents = (id)[UIImage imageNamed:@"calayer_avatar.png"].CGImage;
    [self.view.layer addSublayer:animateLayer];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self.view];
    [self translatonAnimation:location];
    [self rotationAnimation];
}

- (void)translatonAnimation:(CGPoint)location{
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    basicAnimation.toValue = [NSValue valueWithCGPoint:location];
    basicAnimation.duration = 5.0;
    //    basicAnimation.repeatCount = HUGE_VALF;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.delegate = self;
    [basicAnimation setValue:[NSValue valueWithCGPoint:location] forKey:@"KCBasicAnimationLocation"];
    
    [animateLayer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Translation"];
}

-(void)rotationAnimation{
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAnimation.toValue = [NSNumber numberWithFloat:M_PI_2 * 3];
    basicAnimation.duration = 6.0;
    basicAnimation.autoreverses = true;
    [animateLayer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Rotation"];
}

- (void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"animation(%@) start.\r_layer.frame=%@", anim, NSStringFromCGRect(animateLayer.frame));
    NSLog(@"%@",[animateLayer animationForKey:@"KCBasicAnimation_Translation"]);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"animation(%@) stop.\r_layer.frame=%@", anim, NSStringFromCGRect(animateLayer.frame));
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    animateLayer.position = [[anim valueForKey:@"KCBasicAnimationLocation"] CGPointValue];
    
    [CATransaction commit];
}

- (void)drawMyLayer {
    CGPoint position = CGPointMake(160, 200);
    CGRect bounds = CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT);
    CGFloat cornerRadius = PHOTO_HEIGHT / 2;
    CGFloat borderWidth = 2;
    
    CALayer *layerShadow = [[CALayer alloc] init];
    layerShadow.bounds = bounds;
    layerShadow.position = position;
    layerShadow.cornerRadius = cornerRadius;
    layerShadow.shadowColor = [UIColor grayColor].CGColor;
    layerShadow.shadowOffset = CGSizeMake(2, 1);
    layerShadow.shadowOpacity = 1;
    layerShadow.borderColor = [UIColor whiteColor].CGColor;
    layerShadow.borderWidth = borderWidth;
    [self.view.layer addSublayer:layerShadow];
    
    CALayer *layer = [[CALayer alloc] init];
    layer.bounds = bounds;
    layer.position = position;
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.cornerRadius = cornerRadius;
    layer.masksToBounds = YES;
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = borderWidth;
    
    [layer setValue:@M_PI forKeyPath:@"transform.rotation.x"];
    
    layer.delegate = self;
    [self.view.layer addSublayer:layer];
    [layer setNeedsDisplay];
    
//    UIImage *image = [UIImage imageNamed:@"avatar.png"];
//    [layer setContents:(id)image.CGImage];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    UIImage *image = [UIImage imageNamed:@"calayer_avatar.png"];
    
    //This location is relative to layer not screen.
    CGContextDrawImage(ctx, CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT), image.CGImage);
}

- (void)addKCView {
    KCView *view = [[KCView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1];
    [self.view addSubview:view];
}

@end
