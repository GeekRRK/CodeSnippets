//
//  UITableViewVC.m
//  CodeSnippets
//
//  Created by GeekRRK on 16/9/22.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "UITableViewVC.h"
#import "AlDiffModel.h"

@interface UITableViewVC () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *dataArr;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation UITableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *reusableCell = @"ReusableCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableCell];
//    if (cell == nil) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"XXX" owner:nil options:nil] firstObject];
//    }
//    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    
//    return cell;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_dataArr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

/* Deal with different UI cells with different models
- (void)registerCell {
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AlDiffModel *model = _models[indexPath.row];
    UITableViewCell *cell;
    NSString *cellIdentifier = model.cellIdentifier;
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell setModel:model];
    
    return cell;
}
 */

@end
