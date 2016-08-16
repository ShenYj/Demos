//
//  JSHeaderViewController.m
//  HeaderViewScaleByDragging
//
//  Created by ShenYj on 16/8/16.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSHeaderViewController.h"

#define kHeaderHeight 200

@interface JSHeaderViewController () <UITableViewDelegate,UITableViewDataSource>

@end

static NSString *const reuseId = @"Identifier";

@implementation JSHeaderViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    // 取消添加导航栏后控制器的自动偏移
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 设置背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 准备TableView
    [self prepareTableView];
    
    // 准备顶部视图
    [self prepareHeaderView];
    
}

#pragma mark -- 准备顶部视图
- (void)prepareHeaderView{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kHeaderHeight)];
    
    headerView.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:headerView];
}

#pragma mark -- 准备TableView
- (void)prepareTableView{
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    // 设置表格的间隔
    tableView.contentInset = UIEdgeInsetsMake(kHeaderHeight, 0, 0, 0);
    
    // 设置滚动指示器的间距
    tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kHeaderHeight, 0, 0, 0);
    
}

#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseId];
    }
    
    cell.textLabel.text = @(indexPath.row).description;
    
    return cell;
}

#pragma mark -- UITableViewDelegate


#pragma mark -- 设置导航栏样式
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
