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
    
//    [[AlIndicator shareIndicator] showIndicatorWithBlock: ^{
//        sleep(3);
//    } completionBlock:^{
//        UIAlertView *alert =
//        [[UIAlertView alloc] initWithTitle:@"AlIndicator"
//                                   message:@"Welcome to use AlIndicator"
//                                  delegate:nil
//                         cancelButtonTitle:@"Cancel"
//                         otherButtonTitles:@"OK", nil];
//        [alert show];
//    }];
    
    BOOL res = [Utils validateCellPhone:@"12345678901"];
}

@end
