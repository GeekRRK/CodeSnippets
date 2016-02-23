//
//  AlIndicator.h
//  CodeSnippets
//
//  Created by GeekRRK on 2/19/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AlIndicator : NSObject

@property (strong, nonatomic) UIView *bkgView;
@property (strong, nonatomic) UIActivityIndicatorView *indicator;

+ (AlIndicator *)shareIndicator;
- (void)showIndicatorWithBlock:(dispatch_block_t)block completionBlock:(void (^)())completion;

@end
