//
//  JSHeaderViewController.m
//  滚动顶部视图处理练习
//
//  Created by ShenYj on 2016/10/20.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "JSHeaderViewController.h"
#import "JSTableView.h"
#import "Masonry.h"
#import "YYWebImage.h"

static CGFloat kHeaderViewHeight = 200;
static NSString * const reusedID = @"abc";

@interface JSHeaderViewController () <UITableViewDataSource,UITableViewDelegate>

@property (assign,nonatomic) UIStatusBarStyle statusBarStyle;
// 顶部视图
@property (nonatomic) UIView *headerView;
// 顶部视图中的子视图 -> 图片框
@property (nonatomic) UIImageView *headerImageView;
// 底边处理
@property (nonatomic) UIView *bottomLine;
// 列表
@property (nonatomic) JSTableView *tableView;
// 返回按钮
@property (nonatomic) UIButton *backButton;

@end

@implementation JSHeaderViewController

- (instancetype)init {
    self.statusBarStyle = UIStatusBarStyleLightContent;
    return [super init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self prepareTableView];
    
    [self prepareHeaderView];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    self.tableView.contentOffset = CGPointMake(0, -kHeaderViewHeight);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return self.statusBarStyle;
}

#pragma mark
#pragma mark - set up UI

- (void)prepareTableView {
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reusedID];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];
    
    
}

- (void)prepareHeaderView {
    
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.headerImageView];
    [self.headerView addSubview:self.backButton];
    [self.headerView addSubview:self.bottomLine];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(kHeaderViewHeight);
    }];
    
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.headerView);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.headerView);
        make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
    }];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerView).mas_offset(5);
        make.size.mas_equalTo(CGSizeMake(40, 44));
        make.bottom.mas_equalTo(self.headerView).mas_offset(-5);
    }];
    
    
}

#pragma mark 
#pragma mark - target

- (void)clickBackButton:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID forIndexPath:indexPath];
    
    cell.textLabel.text = @(indexPath.row).description;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = kHeaderViewHeight + scrollView.contentOffset.y;
    
    if (offsetY >= 0) {
        
        CGFloat maxOffsetY = kHeaderViewHeight - 64;
        
        CGFloat minOffsetY = MIN(maxOffsetY, offsetY);
        
        CGFloat percent = 1 - (minOffsetY / maxOffsetY);
        
        self.headerImageView.alpha = percent;
        
        self.statusBarStyle = (percent < 0.3) ?  UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
        self.backButton.alpha = (percent < 0.1) ? 1.0 : 0.01;
        
        [self.navigationController setNeedsStatusBarAppearanceUpdate];
        
        // 向上平移
        [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view).mas_offset(-minOffsetY);
            make.height.mas_equalTo(kHeaderViewHeight);
        }];
        
        
        
    } else {
        
        self.backButton.alpha = 0.0;
        self.headerImageView.alpha = 1.0;
        
        // 下拉放大
        [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view).mas_offset(0);
            make.height.mas_equalTo(kHeaderViewHeight - offsetY);
        }];
        
        
    }
    
}


#pragma mark
#pragma mark - Lazy

- (JSTableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[JSTableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(kHeaderViewHeight, 0, 0, 0);
        _tableView.scrollIndicatorInsets = self.tableView.contentInset;
    }
    return _tableView;
}

- (UIView *)headerView {
    
    if (_headerView == nil) {
        _headerView = [[UIView alloc] init];
        _headerView.backgroundColor = [UIColor colorWithRed:249 / 255.0 green:249 / 255.0 blue:249 / 255.0 alpha:1.0];
    }
    return _headerView;
}

- (UIImageView *)headerImageView {
    
    if (_headerImageView == nil) {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.contentMode = UIViewContentModeScaleAspectFill;;
        _headerImageView.clipsToBounds = YES;
        [_headerImageView yy_setImageWithURL:[NSURL URLWithString:@"http://t1.mmonly.cc/uploads/tu/bj/tp/1273/9.jpg"] options:YYWebImageOptionShowNetworkActivity];
    }
    return _headerImageView;
}

- (UIView *)bottomLine {
    
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor redColor];
    }
    return _bottomLine;
}

- (UIButton *)backButton {
    
    if (_backButton == nil) {
        _backButton = [[UIButton alloc] init];
        _backButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _backButton.alpha = 0.0;
        [_backButton setTitle:@"返回" forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(clickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

@end
