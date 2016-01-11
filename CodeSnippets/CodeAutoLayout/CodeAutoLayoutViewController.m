//
//  CodeAutoLayoutViewController.m
//  CodeSnippets
//
//  Created by GeekRRK on 1/9/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "CodeAutoLayoutViewController.h"

@interface CodeAutoLayoutViewController ()

@property (weak, nonatomic) IBOutlet UIButton *buttonAnimation;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cs1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cs2;
@property (strong, nonatomic) NSMutableArray *csArray;
@property (assign, nonatomic) BOOL boolButtonAnimation;

@end

@implementation CodeAutoLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.csArray = [NSMutableArray arrayWithCapacity:0];
}

- (IBAction)animationButtonPress:(id)sender {
    //Remove old constraints first.
    [self.view removeConstraint:self.cs1];
    [self.view removeConstraint:self.cs2];
    [self.view removeConstraints:self.csArray];
    [self.csArray removeAllObjects];
    if (!self.boolButtonAnimation) {
        [UIView transitionWithView:self.buttonAnimation
                          duration:1.0
                           options:UIViewAnimationOptionTransitionFlipFromTop
                        animations:^{
                            [self.buttonAnimation setTranslatesAutoresizingMaskIntoConstraints:NO];
                            self.buttonAnimation.backgroundColor = [UIColor yellowColor];
                            NSDictionary *viewsDictionary = @{@"buttonAnimation":self.buttonAnimation};
                            [self.csArray addObjectsFromArray:[NSLayoutConstraint
                                                               constraintsWithVisualFormat:@"H:|-50-[buttonAnimation(100)]"
                                                               options:0
                                                               metrics:nil
                                                               views:viewsDictionary]];
                            [self.csArray addObjectsFromArray:[NSLayoutConstraint
                                                               constraintsWithVisualFormat:@"V:|-50-[buttonAnimation(100)]"
                                                               options:0
                                                               metrics:nil
                                                               views:viewsDictionary]];
                            [self.view addConstraints:self.csArray];
                            [self.buttonAnimation layoutIfNeeded];
                        } completion:^(BOOL finished) {
                            self.boolButtonAnimation = YES;
                        }];
    } else {
        [UIView transitionWithView:self.buttonAnimation
                          duration:1.0
                           options:UIViewAnimationOptionTransitionFlipFromTop
                        animations:^{
                            [self.buttonAnimation setTranslatesAutoresizingMaskIntoConstraints:NO];
                            self.buttonAnimation.backgroundColor = [UIColor purpleColor];
                            NSDictionary *viewsDictionary = @{@"buttonAnimation":self.buttonAnimation};
                            [self.csArray addObjectsFromArray:[NSLayoutConstraint
                                                               constraintsWithVisualFormat:@"H:|-150-[buttonAnimation(200)]"
                                                               options:0
                                                               metrics:nil
                                                               views:viewsDictionary]];
                            [self.csArray addObjectsFromArray:[NSLayoutConstraint
                                                               constraintsWithVisualFormat:@"V:|-150-[buttonAnimation(200)]"
                                                               options:0
                                                               metrics:nil
                                                               views:viewsDictionary]];
                            [self.view addConstraints:self.csArray];
                            [self.buttonAnimation layoutIfNeeded];
                        } completion:^(BOOL finished) {
                            self.boolButtonAnimation = NO;
                        }];
    }
}

@end
