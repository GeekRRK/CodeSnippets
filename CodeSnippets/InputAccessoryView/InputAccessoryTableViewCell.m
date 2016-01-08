//
//  MyTableViewCell.m
//  CodeSnippets
//
//  Created by GeekRRK on 1/8/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "InputAccessoryTableViewCell.h"

@implementation InputAccessoryTableViewCell

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (UIToolbar *)inputAccessoryView
{
    if(!_inputAccessoryView)
    {
        UIToolbar *toolBar = [[UIToolbar alloc]
                              initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:
                                  UIBarButtonSystemItemDone
                                  target:self
                                  action:@selector(resign)];
        toolBar.items = [NSArray arrayWithObject:right];
        
        return toolBar;
    }
    
    return _inputAccessoryView;
}

- (UIPickerView *)inputView
{
    if(!_inputView)
    {
        UIPickerView *pickView = [[UIPickerView alloc]
                                  initWithFrame:CGRectMake(0, 200, 320, 200)];
        pickView.delegate = self;
        pickView.dataSource = self;
        pickView.showsSelectionIndicator = YES;
        
        return pickView;
    }
    
    return _inputView;
}

- (void)resign
{
    [self resignFirstResponder];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return 5;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%ld",(long)row];
}

@end
