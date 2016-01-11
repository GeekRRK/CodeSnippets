//
//  ScrollViewController.m
//  CodeSnippets
//
//  Created by GeekRRK on 1/9/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController ()

@end

@implementation ScrollViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Very important!
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.scrollView = [[UIScrollView alloc]
                       initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.pageControl = [[UIPageControl alloc]
                        initWithFrame:CGRectMake(0, 200 - 10, 200, 10)];
    self.images = [NSMutableArray
                   arrayWithObjects:
                   [UIImage imageNamed:@"scrollImg1.png"],
                   [UIImage imageNamed:@"scrollImg2.png"],
                   [UIImage imageNamed:@"scrollImg3.png"],
                   [UIImage imageNamed:@"scrollImg4.png"],
                   nil];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    self.view.backgroundColor = [UIColor blackColor];
    [self setupPage];
}

- (void)setupPage
{
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.canCancelContentTouches = NO;
    self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.scrollView.clipsToBounds = YES;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.directionalLockEnabled = NO;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;

    NSUInteger pages = 0;
    int originX = 0;
    for(UIImage *image in self.images)
    {
        UIImageView *pImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        pImageView.backgroundColor =
        [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
        [pImageView setImage:image];
        CGRect rect = self.scrollView.frame;
        rect.origin.x = originX;
        rect.origin.y = 0;
        rect.size.width = self.scrollView.frame.size.width;
        rect.size.height = self.scrollView.frame.size.height;
        pImageView.frame = rect;
        pImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.scrollView addSubview:pImageView];
        originX += self.scrollView.frame.size.width;
        ++pages;
    }
    self.pageControl.numberOfPages = pages;
    self.pageControl.currentPage = 0;
    
    [self.scrollView
     setContentSize:CGSizeMake(originX, self.scrollView.frame.size.height)];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWith = scrollView.frame.size.width;
    int page =
    floor((scrollView.contentOffset.x - pageWith / 2) / pageWith) + 1;
    self.pageControl.currentPage = page;
    
    //When meet NSInteger or NSUInteger,
    //use %zd for signed, %tu for unsigned, and %tx for hex
    NSLog(@"Current page index is: %zd", self.pageControl.currentPage);
}

@end