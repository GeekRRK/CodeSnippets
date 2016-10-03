//
//  MasonryVC.m
//  CodeSnippets
//
//  Created by UGOMEDIA on 16/10/3.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "MasonryVC.h"
#import "Masonry.h"

@interface MasonryVC ()

@end

@implementation MasonryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);
    [view makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(padding);
    }];
}

@end
