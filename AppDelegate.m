//
//  AppDelegate.m
//  CodeSnippets
//
//  Created by GeekRRK on 1/8/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)setRootVCAs:(int)who {
    NSArray *VCArr;
    NSArray *titleArr;
    NSArray *tabitemImgArr;
    
    if (who == 0) {
        ViewController *vc1 = [[ViewController alloc] init];
        ViewController *vc2 = [[ViewController alloc] init];
        ViewController *vc3 = [[ViewController alloc] init];
        
        VCArr = @[vc1, vc2, vc3];
        titleArr = @[@"Dealer", @"Order", @"myself"];
        tabitemImgArr = @[@"tabbar_mydealer", @"tabbar_ordernneeds", @"tabbar_myself"];
    } else if (who == 1) {
        ViewController *vc1 = [[ViewController alloc] init];
        ViewController *vc2 = [[ViewController alloc] init];
        ViewController *vc3 = [[ViewController alloc] init];
        
        VCArr = @[vc1, vc2, vc3];
        titleArr = @[@"Car", @"needs", @"me"];
        tabitemImgArr = @[@"tabbar_carsource", @"tabbar_needs", @"tabbar_me"];
    }
    
    NSMutableArray *navCtrlArr = [[NSMutableArray alloc] init];
    for(int i = 0; i < VCArr.count; ++i) {
        UIViewController *itemVC = VCArr[i];
        itemVC.title = titleArr[i];
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:itemVC];
        navVC.navigationBar.barTintColor = [UIColor blueColor];
        navVC.navigationBar.tintColor = [UIColor whiteColor];
        navVC.navigationBar.translucent = NO;
        [navVC.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        NSString *imgName = tabitemImgArr[i];
        NSString *selImgName = [[NSString alloc] initWithFormat:@"%@_sel", tabitemImgArr[i]];
        navVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:titleArr[i]
                                                         image:[[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                 selectedImage:[[UIImage imageNamed:selImgName]
                                                                imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor grayColor]}
                                                 forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor blueColor]}
                                                 forState:UIControlStateSelected];
        
        [navCtrlArr addObject:navVC];
    }
    
    NSArray *navVCArray = [[NSArray alloc] initWithArray:navCtrlArr];
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    tabBarVC.viewControllers = navVCArray;
    tabBarVC.tabBar.barTintColor = [UIColor lightGrayColor];
    tabBarVC.tabBar.translucent = NO;
    
    self.window.rootViewController = tabBarVC;
}

@end
