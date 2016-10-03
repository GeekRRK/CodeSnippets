//
//  MasonryVC.m
//  CodeSnippets
//
//  Created by GeekRRK on 16/10/3.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "MasonryVC.h"
#import "Masonry.h"
#import "CFUserCenterGridCell.h"

@interface MasonryVC ()

@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UIImageView *avatarImgView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *coinLabel;
@property (strong, nonatomic) UILabel *pointLabel;
@property (strong, nonatomic) UIView *gridView;

@end

@implementation MasonryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    [self setupHeader];
    [self setupGridView];
}

- (void)setupHeader {
    // Header
    _headerView = [[UIView alloc] init];
    [self.view addSubview:_headerView];
    [_headerView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(0);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.equalTo(@163);
    }];
    
    // BackgroundImgae
    UIImageView *bgImgView = [[UIImageView alloc] init];
    [_headerView addSubview:bgImgView];
    [bgImgView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_headerView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    bgImgView.backgroundColor = [UIColor lightGrayColor];
    
    // Avatar
    _avatarImgView = [[UIImageView alloc] init];
    [_headerView addSubview:_avatarImgView];
    [_avatarImgView makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.height.equalTo(@60);
        make.top.equalTo(_headerView).with.offset(21);
        make.centerX.equalTo(_headerView.centerX);
    }];
    _avatarImgView.layer.masksToBounds = YES;
    _avatarImgView.layer.cornerRadius = 60 * 0.5;
    _avatarImgView.image = [UIImage imageNamed:@"usercenter_icon_avatar_default.png"];
    
    // Name
    _nameLabel = [[UILabel alloc] init];
    [_headerView addSubview:_nameLabel];
    [_nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_avatarImgView.bottom).with.offset(11);
        make.centerX.equalTo(_avatarImgView.centerX);
    }];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.text = @"iOS coder";
    
    // Seperator
    UIView *seperator = [[UIView alloc] init];
    [_headerView addSubview:seperator];
    [seperator makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@1);
        make.height.equalTo(@11);
        make.centerX.equalTo(_nameLabel.centerX);
    }];
    seperator.backgroundColor = [UIColor whiteColor];
    
    // PointIcon
    UIImageView *pointIconImgView = [[UIImageView alloc] init];
    [_headerView addSubview:pointIconImgView];
    [pointIconImgView makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@16);
        make.height.equalTo(@16);
        make.left.equalTo(seperator.right).with.offset(18);
        make.centerY.equalTo(seperator.centerY);
        make.top.equalTo(_nameLabel.bottom).with.offset(20);
    }];
    pointIconImgView.image = [UIImage imageNamed:@"usercenter_icon_diamond.png"];
    
    // _pointLabel
    _pointLabel = [[UILabel alloc] init];
    [_headerView addSubview:_pointLabel];
    [_pointLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pointIconImgView.right).with.offset(10);
        make.centerY.equalTo(pointIconImgView.centerY);
    }];
    _pointLabel.font = [UIFont systemFontOfSize:14];
    _pointLabel.textColor = [UIColor whiteColor];
    _pointLabel.text = @"Point  10000";
    
    // _coinLabel
    _coinLabel = [[UILabel alloc] init];
    [_headerView addSubview:_coinLabel];
    [_coinLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(seperator.left).with.offset(-18);
        make.centerY.equalTo(seperator.centerY);
    }];
    _coinLabel.font = [UIFont systemFontOfSize:14];
    _coinLabel.textColor = [UIColor whiteColor];
    _coinLabel.text = @"Coin  10000";
    
    // CoinIcon
    UIImageView *coinImgView = [[UIImageView alloc] init];
    [_headerView addSubview:coinImgView];
    [coinImgView makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@16);
        make.height.equalTo(@16);
        make.right.equalTo(_coinLabel.left).with.offset(-10);
        make.centerY.equalTo(_coinLabel.centerY);
    }];
    coinImgView.image = [UIImage imageNamed:@"usercenter_icon_money.png"];
}

- (void)setupGridView {
    _gridView = [[UIView alloc] init];
    [self.view addSubview:_gridView];
    [_gridView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerView.bottom);
        make.leading.equalTo(_headerView.leading);
        make.trailing.equalTo(_headerView.trailing);
        make.bottom.equalTo(self.view.bottom);
    }];
    
    NSArray *imgNameArr = @[@"usercenter_icon_avatar_default.png", @"usercenter_icon_avatar_default.png", @"usercenter_icon_avatar_default.png",
                            @"usercenter_icon_avatar_default.png", @"usercenter_icon_avatar_default.png", @"usercenter_icon_avatar_default.png",
                            @"usercenter_icon_avatar_default.png", @"usercenter_icon_avatar_default.png", @"usercenter_icon_avatar_default.png"];
    
    NSArray *titleArr = @[@"title1", @"title2", @"title3",
                          @"title4", @"title5", @"title6",
                          @"title7", @"title8", @"title9"];
    
    int columnCnt = 3;
    int rowCnt = 3;
    
    NSMutableArray *cellArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < titleArr.count; ++i) {
        CFUserCenterGridCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"CFUserCenterGridCell" owner:nil options:nil] firstObject];
        [_gridView addSubview:cell];
        cell.btn.tag = i + 1;
        cell.thumbImgView.image = [UIImage imageNamed:imgNameArr[i]];
        cell.titleLabel.text = titleArr[i];
        [cell.btn addTarget:self action:@selector(clickGridCellBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        int columnNum = i % columnCnt;
        
        if (i == 0) {
            [cell makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(_gridView.leading);
                make.top.equalTo(_gridView.top);
            }];
        } else if (i == titleArr.count - 1) {
            [cell makeConstraints:^(MASConstraintMaker *make) {
                CFUserCenterGridCell *preCell = cellArr[i - 1];
                make.trailing.equalTo(_gridView.trailing);
                make.bottom.equalTo(_gridView.bottom);
                make.width.equalTo(preCell.width);
                make.height.equalTo(preCell.height);
                make.leading.equalTo(preCell.trailing);
                make.top.equalTo(preCell.top);
            }];
        } else if (columnNum == 0) {
            [cell makeConstraints:^(MASConstraintMaker *make) {
                CFUserCenterGridCell *upCell = cellArr[i - columnCnt];
                make.leading.equalTo(upCell.leading);
                make.top.equalTo(upCell.bottom);
                make.width.equalTo(upCell.width);
                make.height.equalTo(upCell.height);
            }];
        } else if (columnNum == columnCnt - 1) {
            [cell makeConstraints:^(MASConstraintMaker *make) {
                CFUserCenterGridCell *preCell = cellArr[i - 1];
                make.top.equalTo(preCell.top);
                make.leading.equalTo(preCell.trailing);
                make.trailing.equalTo(_gridView.trailing);
                make.width.equalTo(preCell.width);
                make.height.equalTo(preCell.height);
            }];
        } else {
            [cell makeConstraints:^(MASConstraintMaker *make) {
                CFUserCenterGridCell *preCell = cellArr[i - 1];
                make.top.equalTo(preCell.top);
                make.leading.equalTo(preCell.trailing);
                make.width.equalTo(preCell.width);
                make.height.equalTo(preCell.height);
            }];
        }
        
        [cellArr addObject:cell];
    }
    
    for (int i = 0; i < columnCnt; ++i) {
        UIView *seperator = [[UIView alloc] init];
        seperator.backgroundColor = [UIColor lightGrayColor];
        [_gridView addSubview:seperator];
        
        [seperator makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@0.5);
            make.top.equalTo(_gridView.top);
            make.bottom.equalTo(_gridView.bottom);
        }];
        
        CFUserCenterGridCell *cell = cellArr[i];
        [seperator makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(cell.trailing);
        }];
    }
    
    for (int i = 0; i < rowCnt; ++i) {
        UIView *seperator = [[UIView alloc] init];
        seperator.backgroundColor = [UIColor lightGrayColor];
        [_gridView addSubview:seperator];
        
        [seperator makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.leading.equalTo(_gridView.leading);
            make.trailing.equalTo(_gridView.trailing);
        }];
        
        CFUserCenterGridCell *cell = cellArr[i * rowCnt];
        [seperator makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.bottom);
        }];
    }
}

- (void)clickGridCellBtn:(UIButton *)btn {
    NSInteger tag = btn.tag;
    
    if (tag == 1) {
        NSLog(@"click button 1");
    } else if (tag == 2) {
        NSLog(@"click button 2");
    } else if (tag == 3) {
        NSLog(@"click button 3");
    } else if (tag == 4) {
        NSLog(@"click button 4");
    } else if (tag == 5) {
        NSLog(@"click button 5");
    } else if (tag == 6) {
        NSLog(@"click button 6");
    } else if (tag == 7) {
        NSLog(@"click button 7");
    } else if (tag == 8) {
        NSLog(@"click button 8");
    } else if (tag == 9) {
        NSLog(@"click button 9");
    }
}

@end
