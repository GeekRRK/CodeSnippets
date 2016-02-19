//
//  AlIndicator.m
//  CodeSnippets
//
//  Created by suorui on 2/19/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "AlIndicator.h"

@implementation AlIndicator

+ (AlIndicator *)shareIndicator
{
    static AlIndicator *util;
    static dispatch_once_t temp;
    
    dispatch_once(&temp, ^{
        util = [[AlIndicator alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:util selector:@selector(recevieCancelNotification:) name:@"NTF_CANCEL" object:nil];
    });
    
    return util;
}

- (void)showIndicatorWithBlock:(dispatch_block_t)block completionBlock:(void (^)())completion
{
    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
    
    if(_bkgView == nil) {
        _bkgView = [[UIView alloc] initWithFrame:keyWindow.rootViewController.view.bounds];
        _bkgView.backgroundColor = [UIColor whiteColor];
        _bkgView.alpha = 0.5;
        [keyWindow addSubview:_bkgView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel)];
        [_bkgView addGestureRecognizer:tapGesture];
    }
    
    if(_indicator == nil) {
        _indicator = [[UIActivityIndicatorView alloc] init];
        _indicator.color = [UIColor grayColor];
        _indicator.center = [keyWindow.rootViewController.view center];
        [_bkgView addSubview:_indicator];
    }
    
    
    
    [keyWindow bringSubviewToFront:_bkgView];
    _bkgView.hidden = NO;
    _indicator.hidden = NO;
    [_indicator startAnimating];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        block();
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [_indicator stopAnimating];
            _indicator.hidden = YES;
            _bkgView.hidden = YES;
            
            completion();
        });
    });
}

- (void)cancel {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NTF_CANCEL" object:self];
}

- (void)recevieCancelNotification:(NSNotification *)notification {
    if ([[notification name] isEqualToString:@"NTF_CANCEL"]) {
        NSLog (@"How to kill a running thread from GCD?");
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
