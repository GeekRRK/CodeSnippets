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
#import "MasonryVC.h"
#import "NSObject+AlBuilder.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    // view 1
    UIView *v1 = [UIView z0_builder:^(UIView *that) {
        that.frame = CGRectMake(0, 0, 320, 200);
        that.backgroundColor = [UIColor blackColor];
    }];
    
    // view 2
    UIView *v2 = [[UIView alloc] init];
    [v2 z0_builder:^(UIView *that) {
        that.frame = CGRectMake(0, 0, 320, 200);
        that.backgroundColor = [UIColor redColor];
    }];
    
    [self.view addSubview:v1];
    [self.view addSubview:v2];
}

@end
