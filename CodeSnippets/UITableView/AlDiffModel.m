//
//  AlDiffModel.m
//  CodeSnippets
//
//  Created by UGOMEDIA on 16/10/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "AlDiffModel.h"
#import <UIKit/UIKit.h>

@implementation AlDiffModel

- (NSString *)cellIdentifier {
    if (_type == PersonShowNameAndAvatar) {
        return NSStringFromClass([UITableViewCell class]);
    } else if (_type == PersonShowAvatar){
        return NSStringFromClass([UITableViewCell class]);
    } else {
        return NSStringFromClass([UITableViewCell class]);
    }
}

@end
