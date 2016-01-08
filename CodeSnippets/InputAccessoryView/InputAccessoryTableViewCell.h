//
//  MyTableViewCell.h
//  CodeSnippets
//
//  Created by suorui on 1/8/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputAccessoryTableViewCell : UITableViewCell
<UIPickerViewDataSource, UIPickerViewDelegate>
{
    UIToolbar *_inputAccessoryView;
    UIPickerView *_inputView;
}

@property(strong, nonatomic, readwrite) UIToolbar *inputAccessoryView;
@property(strong, nonatomic, readwrite) UIPickerView *inputView;

@end
