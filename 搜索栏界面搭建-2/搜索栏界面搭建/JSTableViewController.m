//
//  JSTableViewController.m
//  搜索栏界面搭建
//
//  Created by ShenYj on 16/9/19.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSTableViewController.h"

@interface JSTableViewController ()

@property (nonatomic,assign,getter=isShowResultData) BOOL showResultData;

@end

@implementation JSTableViewController{
    
    NSArray             *_data;
    NSMutableArray      *_resultArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareView];
    
    _data = @[
              @{@"category":@"Chocolate", @"name":@"Chocolate Bar1"},
              @{@"category":@"Chocolate", @"name":@"Chocolate Chip1"},
              @{@"category":@"Chocolate", @"name":@"Dark Chocolate1"},
              @{@"category":@"Hard", @"name":@"Lollipop1"},
              @{@"category":@"Hard", @"name":@"Candy Cane1"},
              @{@"category":@"Hard", @"name":@"Jaw Breaker1"},
              @{@"category":@"Other", @"name":@"Caramel1"},
              @{@"category":@"Other", @"name":@"Sour Chew1"},
              @{@"category":@"Other", @"name":@"Gummi Bear"},
              @{@"category":@"Chocolate", @"name":@"Chocolate Bar2"},
              @{@"category":@"Chocolate", @"name":@"Chocolate Chip2"},
              @{@"category":@"Chocolate", @"name":@"Dark Chocolate2"},
              @{@"category":@"Hard", @"name":@"Lollipop2"},
              @{@"category":@"Hard", @"name":@"Candy Cane2"},
              @{@"category":@"Hard", @"name":@"Jaw Breaker2"},
              @{@"category":@"Other", @"name":@"Caramel2"},
              @{@"category":@"Other", @"name":@"Sour Chew2"},
              @{@"category":@"Other", @"name":@"Gummi Bear2"},
              @{@"category":@"Chocolate", @"name":@"Chocolate Bar3"},
              @{@"category":@"Chocolate", @"name":@"Chocolate Chip3"},
              @{@"category":@"Chocolate", @"name":@"Dark Chocolate3"},
              @{@"category":@"Hard", @"name":@"Lollipop3"},
              @{@"category":@"Hard", @"name":@"Candy Cane3"},
              @{@"category":@"Hard", @"name":@"Jaw Breaker3"},
              @{@"category":@"Other", @"name":@"Caramel3"},
              @{@"category":@"Other", @"name":@"Sour Chew3"},
              @{@"category":@"Other", @"name":@"Gummi Bear3"}
              ];
    
}

- (void)prepareView {
    
    self.tableView.backgroundColor = [UIColor orangeColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.isShowResultData) {
        
        return _resultArr.count;
    }
    
    return _data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuser"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuser"];
    }
    
    
    if (self.isShowResultData) {
        
        cell.textLabel.text = _resultArr[indexPath.row][@"category"];
        cell.detailTextLabel.text = _resultArr[indexPath.row][@"name"];

    } else {
        
        cell.textLabel.text = _data[indexPath.row][@"category"];
        cell.detailTextLabel.text = _data[indexPath.row][@"name"];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%s",__func__);
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    self.showResultData = searchController.isActive;
    
    NSString *searchString = searchController.searchBar.text;
    
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    
    if (_resultArr != nil) {
        
        [_resultArr removeAllObjects];
    }
    
    // 过滤数据
    _resultArr = [NSMutableArray arrayWithArray:[_data filteredArrayUsingPredicate:preicate]];
    
    [self.tableView reloadData];
    
}


@end
