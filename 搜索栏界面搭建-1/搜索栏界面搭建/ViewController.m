//
//  ViewController.m
//  搜索栏界面搭建
//
//  Created by ShenYj on 16/9/19.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"
#import "JSHeaderView.h"
#import "Masonry.h"


@interface ViewController () <UISearchBarDelegate,UISearchResultsUpdating>

@property (nonatomic,strong) JSHeaderView *headerView;

@property (nonatomic,strong) UISearchController  *searchController;

@end

@implementation ViewController{
    
        NSArray             *_data;
        NSMutableArray      *_resultArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    
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
    
    [self prepareView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    UIView *view = [[UIView alloc ]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 200 - 64)];
    view.backgroundColor = [UIColor redColor];
    self.navigationItem.titleView = view;
    
    [view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.navigationController.navigationBar);
        make.right.mas_equalTo(self.navigationController.navigationBar);
        make.top.mas_equalTo(self.navigationController.navigationBar.mas_bottom);
        make.height.mas_equalTo(200);
    }];
    
    //[self addChildViewController:self.searchController];
//    [self.headerView addSubview:self.searchController.searchBar];
//    [self.searchController.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.headerView).mas_offset(5);
//        make.right.mas_equalTo(self.headerView).mas_offset(-60);
//        make.height.mas_equalTo(44);
//        make.bottom.mas_equalTo(self.headerView);
//    }];

    
    
}

- (void)prepareView {
    //mTableView.contentOffset = CGPointMake(0, CGRectGetHeight(resultSearchController.searchBar.frame))
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(clickButton:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(clickButton:)];
    
    self.tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(200, 0, 0, 0);
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

#pragma mark - target 

- (void)clickButton:(UIBarButtonItem *)sender {
    
    NSLog(@"%s",__func__);
}



#pragma mark - lazy

- (JSHeaderView *)headerView {
    
    if (_headerView == nil) {
        _headerView = [[JSHeaderView alloc] init];
    }
    return _headerView;
}

- (UISearchController *)searchController {
    
    if (_searchController == nil) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        // 设置代理
        _searchController.searchResultsUpdater = self;
        _searchController.searchBar.delegate = self;
        
        // 设置属性
        // 默认情况下,UISearchController会暗化前一个视图
        _searchController.dimsBackgroundDuringPresentation = NO;
        //保证在UISearchController在激活状态下用户push到下一个view controller之后search bar不会仍留在界面上。
        //_searchController.definesPresentationContext = YES;
        // 是否隐藏导航栏
        _searchController.hidesNavigationBarDuringPresentation = NO;
        // 设置占位文字
        _searchController.searchBar.placeholder = @"Search here...";
        
        
//        _searchController.searchBar.selectedScopeButtonIndex = 1;
//        _searchController.searchBar.scopeButtonTitles = @[@"1",@"2"];
    }
    return _searchController;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    NSString *searchString = searchController.searchBar.text;
    
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    
    if (_resultArr != nil) {
        
        [_resultArr removeAllObjects];
    }
    
    // 过滤数据
    _resultArr = [NSMutableArray arrayWithArray:[_data filteredArrayUsingPredicate:preicate]];
    
    [self.tableView reloadData];
    
}

#pragma mark - UISearchBarDelegate
// return NO to not become first responder
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"%s",__func__);
    return YES;
}
// called when text starts editing
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"%s",__func__);
}
// return NO to not resign first responder
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    NSLog(@"%s",__func__);
    return YES;
}
// called when text ends editing
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    NSLog(@"%s",__func__);
}
// called when text changes (including clear)
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"%s",__func__);
}
// called before text changes
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSLog(@"%s",__func__);
    return YES;
}
// called when keyboard search button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"%s",__func__);
}
// called when bookmark button pressed
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"%s",__func__);
}
// called when cancel button pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"%s",__func__);
}
// called when search results button pressed
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"%s",__func__);
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{
    NSLog(@"%s",__func__);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.searchController.isActive) {
        
        return _resultArr.count;
    }
    
    return _data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuser"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuser"];
    }
    
    
    if (self.searchController.isActive) {
        
        cell.textLabel.text = _resultArr[indexPath.row][@"category"];
        cell.detailTextLabel.text = _resultArr[indexPath.row][@"name"];
        
    } else {
        
        cell.textLabel.text = _data[indexPath.row][@"category"];
        cell.detailTextLabel.text = _data[indexPath.row][@"name"];
        
    }
    
    return cell;
}


@end
