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
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    // Header
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:headerView];
    [headerView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(0);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.equalTo(@155);
    }];
    
    // BackgroundImgae
    UIImageView *bgImgView = [[UIImageView alloc] init];
    [headerView addSubview:bgImgView];
    [bgImgView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headerView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    bgImgView.image = [UIImage imageNamed:@"usercenter_header_bg.png"];
    
    // Avatar
    UIImageView *avatarImgView = [[UIImageView alloc] init];
    [headerView addSubview:avatarImgView];
    [avatarImgView makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.height.equalTo(@60);
        make.top.equalTo(headerView).with.offset(21);
        make.centerX.equalTo(headerView.centerX);
    }];
    avatarImgView.layer.masksToBounds = YES;
    avatarImgView.layer.cornerRadius = 60 * 0.5;
    avatarImgView.image = [UIImage imageNamed:@"usercenter_icon_avatar_default.png"];
    
    // Name
    
    // Seperator
    
    // CoinLabel
    
    // CoinIcon
    
    // PointIcon
    
    // PointLabel
}

@end
