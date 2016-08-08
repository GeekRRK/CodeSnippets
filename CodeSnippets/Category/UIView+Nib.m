//
//  UIView+Nib.m
//  CodeSnippets
//
//  Created by UGOMEDIA on 16/8/8.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "UIView+Nib.h"

@implementation UIView (Nib)

+ (id)loadFromNib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

@end
