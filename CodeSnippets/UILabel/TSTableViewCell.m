//
//  TSTableViewCell.m
//  CodeSnippets
//
//  Created by UGOMEDIA on 16/8/9.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "TSTableViewCell.h"
#import "TSLabel.h"

@implementation TSTableViewCell
{
    IBOutlet TSLabel* _label;
}

- (void) setText: (NSString *) text
{
    _label.text = text;
}


@end
