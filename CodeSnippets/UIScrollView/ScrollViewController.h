//
//  ScrollViewController.h
//  CodeSnippets
//
//  Created by GeekRRK on 1/9/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) NSMutableArray *images;

@end
