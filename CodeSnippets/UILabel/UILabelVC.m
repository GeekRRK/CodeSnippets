//
//  UILabelVC.m
//  CodeSnippets
//
//  Created by GeekRRK on 16/10/18.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "UILabelVC.h"

@interface UILabelVC ()

@end

@implementation UILabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 3;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:contentLabel.text];
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, attrStr.length)];
    contentLabel.attributedText = attrStr;
}

@end
