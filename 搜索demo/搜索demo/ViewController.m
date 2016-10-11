//
//  ViewController.m
//  搜索demo
//
//  Created by ShenYj on 2016/10/11.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "ViewController.h"
#import "JSHeaderView.h"
#import "JSTableViewController.h"
#import "Masonry.h"


@interface ViewController ()
@property (nonatomic,strong) JSHeaderView *headerView;

@property (nonatomic,strong) JSTableViewController *tableViewController;

@property (nonatomic,strong) UISearchController  *searchController;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareView];
}

- (void)prepareView {
    
    [self.view addSubview:self.headerView];
    [self addChildViewController:self.tableViewController];
    [self.view addSubview:self.tableViewController.tableView];
    //    [self addChildViewController:self.searchController];
    //    [self.view addSubview:self.searchController.searchBar];
    
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
    
    [self.tableViewController.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom).mas_offset(0);
        make.bottom.left.right.mas_equalTo(self.view);
    }];
    
    //    [self.searchController.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.bottom.mas_equalTo(self.headerView);
    //        make.right.mas_equalTo(self.headerView).mas_offset(-60);
    //        make.height.mas_equalTo(44);
    //    }];
    
    
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
        _searchController = [[UISearchController alloc] initWithSearchResultsController:self.tableViewController];
        // 设置代理
        _searchController.searchResultsUpdater = self.tableViewController;
        _searchController.searchBar.delegate = self;
        // 设置属性
        // 默认情况下,UISearchController会暗化前一个视图
        _searchController.dimsBackgroundDuringPresentation = NO;
        //保证在UISearchController在激活状态下用户push到下一个view controller之后search bar不会仍留在界面上。
        _searchController.definesPresentationContext = YES;
        // 是否隐藏导航栏
        _searchController.hidesNavigationBarDuringPresentation = NO;
        // 设置占位文字
        _searchController.searchBar.placeholder = @"Search here...";
    }
    return _searchController;
}


- (JSTableViewController *)tableViewController {
    
    if (_tableViewController == nil) {
        _tableViewController = [[JSTableViewController alloc] init];
    }
    return _tableViewController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UISearchBarDelegate
// return NO to not become first responder
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    return YES;
}
// called when text starts editing
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"%s",__func__);
}
// return NO to not resign first responder
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    
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
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0){
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




@end
