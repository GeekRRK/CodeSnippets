//
//  UINavigationBarViewController.m
//  CodeSnippets
//
//  Created by suorui on 1/11/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "UINavigationBarViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface UINavigationBarViewController ()

@end

@implementation UINavigationBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Title";
    
    //Use `[UINavigationBar appearance]` only in `didFinishLaunchingWithOptions`.
    
    [self.navigationController.navigationBar
     setBarTintColor:UIColorFromRGB(0x067AB5)];
    
    [self.navigationController.navigationBar
     setBackgroundImage:[UIImage imageNamed:@"nav_bg_ios7.png"]
     forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar
     setBackIndicatorImage:[UIImage imageNamed:@"back_btn.png"]];
    [self.navigationController.navigationBar
     setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back_btn.png"]];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [self.navigationController.navigationBar setTitleTextAttributes:
    [NSDictionary dictionaryWithObjectsAndKeys:
    [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0],
    NSForegroundColorAttributeName,
    shadow, NSShadowAttributeName,
    [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
    
    self.navigationItem.titleView =
    [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"appcoda-logo.png"]];
    
    UIBarButtonItem *shareItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                  target:self
                                                  action:nil];
    UIBarButtonItem *cameraItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                                  target:self
                                                  action:nil];
    
    NSArray *actionButtonItems = @[shareItem, cameraItem];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    
    // Set View controller-based status bar appearance to NO in info.plist then
    // the following code will work for all.
    // [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    // `preferredStatusBarStyle` only be invoked in navigation controller when view
    // controller in UINavigationController, so use the following code to white the status bar.
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

// `preferredStatusBarStyle` only be invoked in navigation controller when view
// controller in UINavigationController, so the following code won't be invoked.
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

// Alternatively, subclass from UINavigationController and overide the
// following method
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    UIViewController *topVC = self.topViewController;
//    return [topVC preferredStatusBarStyle];
//}

//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}

@end
