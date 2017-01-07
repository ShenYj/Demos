//
//  ViewController.m
//  RefreshTest
//
//  Created by ShenYj on 2017/1/7.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "ViewController.h"
#import "JSRefreshControl.h"

/** 常量: 顶部视图高度 */
static CGFloat const kHeaderViewHeight = 400.f;

static NSString * const reuseId = @"abc";

@interface ViewController ()

/** 表格 */
@property (nonatomic) UITableView *tableView;
/** 下拉刷新控件 */
@property (nonatomic) JSRefreshControl *js_refreshControl;
/** 顶部视图 */
@property (nonatomic) UIView *headView;
/** 自定义导航栏 */
@property (nonatomic) UIView *navigationBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseId];
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.js_refreshControl];
    [self.js_refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    self.tableView.contentInset = UIEdgeInsetsMake(kHeaderViewHeight, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    [self.view addSubview:self.headView];
    [self.view addSubview:self.navigationBar];
    //[self loadData];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)loadData {
    [self.js_refreshControl beginRefresh];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.js_refreshControl endRefresh];
    });

}


#pragma mark
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId forIndexPath:indexPath];
    cell.textLabel.text = @(indexPath.row).description;
    cell.backgroundColor = [UIColor whiteColor];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    return cell;
}

#pragma mark
#pragma mark - UITableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat contentOffsetY = self.tableView.contentInset.top + self.tableView.contentOffset.y;
    // 向上滚动表格
    if (contentOffsetY > 0 ) {
        // 临界值
        CGFloat maxContentOffsetY = kHeaderViewHeight - 64;
        CGFloat currentY = -MIN(maxContentOffsetY, contentOffsetY);
        
        CGFloat alpha = 1 - contentOffsetY / maxContentOffsetY;
        self.navigationBar.alpha = alpha;
        
        self.headView.frame = CGRectMake(0, currentY , [UIScreen mainScreen].bounds.size.width, kHeaderViewHeight);
        
    } else { // 向下滚动表格
        self.navigationBar.alpha = 1;
        self.headView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kHeaderViewHeight);
    }
    
    
}

#pragma mark
#pragma mark - lazy

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = self.view.bounds;
        _tableView.backgroundColor = [UIColor greenColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (JSRefreshControl *)js_refreshControl {
    if (!_js_refreshControl) {
        _js_refreshControl = [[JSRefreshControl alloc] init];
    }
    return _js_refreshControl;
}

- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] init];
        _headView.backgroundColor = [UIColor orangeColor];
        _headView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kHeaderViewHeight);
    }
    return _headView;
}

- (UIView *)navigationBar {
    if (!_navigationBar) {
        _navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
        _navigationBar.backgroundColor = [UIColor yellowColor];
    }
    return _navigationBar;
}

@end
