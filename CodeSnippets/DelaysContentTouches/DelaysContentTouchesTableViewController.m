//
//  DelaysContentTouchesTableViewController.m
//  CodeSnippets
//
//  Created by GeekRRK on 1/8/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "DelaysContentTouchesTableViewController.h"
#import "DelaysContentTouchesTableViewCell.h"

@interface DelaysContentTouchesTableViewController ()

@end

@implementation DelaysContentTouchesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DelaysContentTouchesTableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if(cell == nil) {
        NSArray *nibArr =
        [[NSBundle mainBundle] loadNibNamed:@"DelaysContentTouchesTableViewCell"
                                      owner:nil
                                    options:nil];
        cell = [nibArr firstObject];
    }
    
    return cell;
}

@end
