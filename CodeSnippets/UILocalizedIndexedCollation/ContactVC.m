//
//  ViewController.m
//  Demo_Contact
//
//  Created by Geek on 16-7-10.
//  Copyright (c) 2016年 GeekRRK. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (copy, nonatomic) NSArray *contactArr;
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UILocalizedIndexedCollation *collation;
@property (strong, nonatomic) NSMutableArray *sectionsArray;
@property (strong, nonatomic) NSMutableArray *sectionTitleArray;

@property (strong, nonatomic) NSMutableArray *validSectionsArray;
@property (strong, nonatomic) NSMutableArray *validSectionTitleArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person *p1 = [[Person alloc] init];
    Person *p2 = [[Person alloc] init];
    Person *p3 = [[Person alloc] init];
    Person *p4 = [[Person alloc] init];
    Person *p5 = [[Person alloc] init];
    p1.name = @"王猫";
    p2.name = @"阿亮";
    p3.name = @"露西";
    p4.name = @"B哥";
    p5.name = @"强子";
    
    _contactArr = @[p1, p2, p3, p4, p5];
    
    [self indexContact];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)indexContact {
    _collation = [UILocalizedIndexedCollation currentCollation];
    
    NSInteger sectionTitlesCount = [[_collation sectionTitles] count];
    
    _sectionsArray = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
    
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [_sectionsArray addObject:array];
    }
    
    for (Person *p in _contactArr) {
        NSInteger sectionNumber = [_collation sectionForObject:p collationStringSelector:@selector(name)];
        NSMutableArray *sectionNames = _sectionsArray[sectionNumber];
        [sectionNames addObject:p];
    }
    
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *personArrayForSection = _sectionsArray[index];
        NSArray *sortedPersonArrayForSection = [_collation sortedArrayFromArray:personArrayForSection collationStringSelector:@selector(name)];
        _sectionsArray[index] = sortedPersonArrayForSection;
    }
    
    _validSectionsArray = [[NSMutableArray alloc] init];
    _validSectionTitleArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < _sectionsArray.count; ++i) {
        NSMutableArray *arr = _sectionsArray[i];
        if (arr.count > 0) {
            [_validSectionsArray addObject:arr];
            [_validSectionTitleArray addObject: _collation.sectionIndexTitles[i]];
        }
    }
    
    [_validSectionsArray insertObject:@"群组" atIndex:0];
    [_validSectionTitleArray insertObject:@"" atIndex:0];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _validSectionTitleArray[section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _validSectionTitleArray;
}

//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//    return [_collation sectionForSectionIndexTitleAtIndex:index];
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _validSectionsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        NSArray *arr = _validSectionsArray[section];
        return arr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    
    NSArray *arr = _validSectionsArray[indexPath.section];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"群组";
    } else {
        Person *p = arr[indexPath.row];
        cell.textLabel.text = p.name;
    }
    
    return cell;
}

@end
