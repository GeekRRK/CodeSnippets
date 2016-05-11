//
//  ViewController.m
//  CodeSnippets
//
//  Created by GeekRRK on 1/8/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "ViewController.h"
#import "CodeSnippets-Swift.h"
#import "AlIndicator.h"
#import "Utils.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SwiftViewController *swiftVC = [[SwiftViewController alloc] init];
    [self.view addSubview:swiftVC.view];
}

@end
