//
//  UITextFieldVC.m
//  CodeSnippets
//
//  Created by GeekRRK on 16/8/10.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "UITextFieldVC.h"

@interface UITextFieldVC () <UITextFieldDelegate>

@property (strong, nonatomic) UITextField *textField;

@end

@implementation UITextFieldVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textField.delegate = self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    if ([[[_textField textInputMode] primaryLanguage] isEqualToString:@"emoji"]) {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    return newLength <= 11;
}

@end
