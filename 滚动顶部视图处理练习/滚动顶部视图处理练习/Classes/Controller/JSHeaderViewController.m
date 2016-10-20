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

@property (nonatomic) UIView *headerView;

@property (nonatomic) UIImageView *headerImageView;

@property (nonatomic) JSTableView *tableView;


@end

@implementation JSHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self prepareTableView];
    
    [self prepareViewHeaderView];
    
}

- (void)prepareTableView {
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reusedID];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];
    
    self.tableView.contentInset = UIEdgeInsetsMake(kHeaderViewHeight, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kHeaderViewHeight, 0, 0, 0);
    
}

- (void)prepareViewHeaderView {
    
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(kHeaderViewHeight);
    }];
    
    [self.headerView addSubview:self.headerImageView];
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.headerView);
    }];
    
    
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


#pragma mark
#pragma mark - Lazy

- (JSTableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[JSTableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIView *)headerView {
    
    if (_headerView == nil) {
        _headerView = [[UIView alloc] init];
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



@end
