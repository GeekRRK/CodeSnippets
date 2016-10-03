//
//  CFUserCenterGridCell.m
//  Quiz
//
//  Created by GeekRRK on 16/9/23.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "CFUserCenterGridCell.h"

@implementation CFUserCenterGridCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _titleLabel.textColor = [UIColor blackColor];
    self.backgroundColor = [UIColor whiteColor];
}

@end
