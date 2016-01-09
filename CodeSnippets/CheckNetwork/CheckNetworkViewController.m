//
//  CheckNetworkViewController.m
//  CodeSnippets
//
//  Created by suorui on 1/9/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "CheckNetworkViewController.h"
#import "Reachability.h"

@interface CheckNetworkViewController ()

@end

@implementation CheckNetworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self isConnectionAvailable];
}

- (NSString *)getLocalNetWorkStates{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]
                          valueForKeyPath:@"foregroundView"] subviews];
    NSString *state = [[NSString alloc] init];
    int netType = 0;

    for (id child in children) {
        if ([child isKindOfClass:
             NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            netType = [[child valueForKeyPath:@"dataNetworkType"] intValue];
            
            switch (netType) {
                case 0:
                    state = @"no network";
                    break;
                case 1:
                    state = @"2g";
                    break;
                case 2:
                    state = @"3g";
                    break;
                case 3:
                    state = @"4g";
                    break;
                case 5:
                {
                    state = @"wifi";
                }
                    break;
                default:
                    break;
            }
        }
    }
    
    return state;
}

/*
 Download Reachability class from 
 https://developer.apple.com/library/ios/samplecode/Reachability/Reachability.zip
 */
- (BOOL)isConnectionAvailable{
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            NSLog(@"wifi");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            NSLog(@"3g");
            break;
    }
    
    return isExistenceNetwork;
}

@end
