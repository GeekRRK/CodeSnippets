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
#import "ImageButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ImageButton *imgBtn = [[ImageButton alloc] initWithFrame:CGRectMake(100, 100, 200, 150)];
    imgBtn.backgroundColor = [UIColor greenColor];
    [imgBtn setTitle:@"首页" forState:UIControlStateNormal];
    [imgBtn setImage:[UIImage imageNamed:@"8.jpg"] forState:UIControlStateNormal];
    [self.view addSubview:imgBtn];
}

@end
