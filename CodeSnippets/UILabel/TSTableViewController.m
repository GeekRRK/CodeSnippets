//
//  TSTableViewController.m
//  CodeSnippets
//
//  Created by UGOMEDIA on 16/8/9.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "TSTableViewController.h"
#import "TSTableViewCell.h"

@interface TSTableViewController ()

@end

@implementation TSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSString*) cellText
{
    return @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
}

#pragma mark - Table view data source

- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView
{
    return 1;
}

- (NSInteger) tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger) section
{
    return 1;
}

- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
    static TSTableViewCell *sizingCell;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sizingCell = (TSTableViewCell*)[tableView dequeueReusableCellWithIdentifier: @"TSTableViewCell"];
    });
    
    // configure the cell
    sizingCell.text = self.cellText;
    
    // force layout
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    // get the fitting size
    CGSize s = [sizingCell.contentView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize];
    NSLog( @"fittingSize: %@", NSStringFromCGSize( s ));
    
    return s.height;
}

- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath
{
    TSTableViewCell *cell = (TSTableViewCell*)[tableView dequeueReusableCellWithIdentifier: @"TSTableViewCell" ];
    
    cell.text = self.cellText;
    
    return cell;
}

@end
