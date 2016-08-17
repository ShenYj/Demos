//
//  JSHeaderViewController.m
//  HeaderViewScaleByDragging
//
//  Created by ShenYj on 16/8/16.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSHeaderViewController.h"
#import "UIImage+Color.h"
#import "UIView+JSFrame.h"

#define kHeaderHeight 200

@interface JSHeaderViewController () <UITableViewDelegate,UITableViewDataSource>

@end

static NSString *const reuseId = @"Identifier";

@implementation JSHeaderViewController{
    
    // 顶部视图
    UIView *_headerView;
    // 顶部视图中的UIImageView
    UIImageView *_headerImageView;
}

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

#pragma mark -- 隐藏导航栏
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    
//    [self.navigationController setNavigationBarHidden:YES];
//}

#pragma mark -- 准备顶部视图
- (void)prepareHeaderView{
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kHeaderHeight)];
    
    _headerView.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:_headerView];
    
    // 顶部视图添加UIImageView
    _headerImageView = [[UIImageView alloc] initWithFrame:_headerView.bounds];
    
    [_headerView addSubview:_headerImageView];
    
    // 设置图像 (使用图片需要考虑性能优化)
    // headerImageView.image =  [UIImage imageNamed:@"headerView"];
    UIImage *image = [UIImage imageNamed:@"headerView"];
    [image js_ImageWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, kHeaderHeight) completion:^(UIImage *img) {
        
        _headerImageView.image = img;
    }];
    
    // 设置等比例拉伸
    _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offSetY = scrollView.contentOffset.y + scrollView.contentInset.top;
    
    NSLog(@"%f",offSetY);
    
    if (offSetY > 0) {
        NSLog(@"整体移动");
        
    }else {
        NSLog(@"放大");
        // 调整HeaderView和HeaderImageView
        _headerView.y = 0;
        _headerView.h = kHeaderHeight - offSetY;
        _headerImageView.h = _headerView.h;
    }
}

#pragma mark -- 设置导航栏样式
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
