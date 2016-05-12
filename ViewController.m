//
//  ViewController.m
//  CodeSnippets
//
//  Created by GeekRRK on 1/8/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "ViewController.h"
#import "CodeSnippets-Swift.h"
#import "AlIndicator.h"
#import "Utils.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDate *fDate = [NSDate date];
    NSDate *tDate = [NSDate dateWithTimeIntervalSinceNow:60 * 3];
    NSInteger minute = [Utils getMinuteFromDate:fDate toDate:tDate];
    NSLog(@"%ld", minute);
}

@end
