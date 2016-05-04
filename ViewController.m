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
#import "KVOViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KVOViewController *kvoVC = [[KVOViewController alloc] init];
    [self.navigationController pushViewController:kvoVC animated:YES];
}

@end
