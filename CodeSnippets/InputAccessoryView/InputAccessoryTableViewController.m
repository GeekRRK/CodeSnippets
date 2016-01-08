//
//  MyTableViewController.m
//  CodeSnippets
//
//  Created by suorui on 1/8/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "InputAccessoryTableViewController.h"
#import "InputAccessoryTableViewCell.h"

@interface InputAccessoryTableViewController ()

@end

@implementation InputAccessoryTableViewController

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
    InputAccessoryTableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if(cell == nil){
        cell = [[InputAccessoryTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:@"reuseIdentifier"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell becomeFirstResponder];
}

@end
