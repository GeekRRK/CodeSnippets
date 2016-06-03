//
//  UICollectionVC.m
//  CodeSnippets
//
//  Created by GeekRRK on 16/6/3.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "UICollectionVC.h"
#import "AlCollectionViewLayout.h"
#import "AlCollectionCell.h"

@interface UICollectionVC () <UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (copy, nonatomic) NSArray *imageNames;

@end

@implementation UICollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageNames = @[@"7.jpg", @"8.jpg", @"9.jpg", @"10.jpg", @"11.jpg", @"12.jpg", @"13.jpg", @"14.jpg",
                        @"15.jpg", @"16.jpg", @"17.jpg", @"18.jpg", @"19.jpg", @"20.jpg", @"21.jpg", @"22.jpg"];
    
    AlCollectionViewLayout *waterfall = [[AlCollectionViewLayout alloc] init];
    waterfall.columnCount = 3;
    waterfall.columnSpacing = 10;
    waterfall.rowSpacing = 10;
    waterfall.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [waterfall setItemHeightBlock:^CGFloat(CGFloat itemWidth, NSIndexPath *indexPath) {
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imageNames[indexPath.item]]];
        return image.frame.size.height / image.frame.size.width * itemWidth;
    }];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:waterfall];
    [self.collectionView registerNib:[UINib nibWithNibName:@"AlCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"AlCell"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AlCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AlCell" forIndexPath:indexPath];
    cell.imgView.image = [UIImage imageNamed:self.imageNames[indexPath.row]];
    
    return cell;
}

@end
