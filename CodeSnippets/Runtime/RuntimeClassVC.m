//
//  RuntimeClassVC.m
//  CodeSnippets
//
//  Created by GeekRRK on 1/21/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "RuntimeClassVC.h"

@interface RuntimeClassVC () <UITableViewDelegate, UITableViewDataSource>{
    int m_int;
}

@property (strong, nonatomic) NSMutableArray *p_mutarray;

@end

@implementation RuntimeClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)m_method {
    NSLog(@"m_method");
}

@end
