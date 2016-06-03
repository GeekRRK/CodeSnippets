//
//  YZCollectionViewLayout.h
//  Collection
//
//  Created by GeekRRK on 16/6/2.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlCollectionViewLayout : UICollectionViewLayout

@property (assign, nonatomic) NSInteger columnCount;
@property (assign, nonatomic) NSInteger columnSpacing;
@property (assign, nonatomic) NSInteger rowSpacing;
@property (assign, nonatomic) UIEdgeInsets sectionInset;
@property (strong, nonatomic) NSMutableDictionary *maxYDic;
@property (strong, nonatomic) NSMutableArray *attributesArray;

@property (strong, nonatomic) CGFloat(^itemHeightBlock)(CGFloat itemWidth, NSIndexPath *indexPath);

@end
