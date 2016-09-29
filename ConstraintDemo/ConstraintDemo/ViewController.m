//
//  ViewController.m
//  layoutConstraintTest
//
//  Created by ShenYj on 16/9/29.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"
#import "JSTableViewController.h"
#import "Masonry.h"

@interface ViewController ()

@property (nonatomic,strong) UILabel *detailLabel;

@property (nonatomic,strong) JSTableViewController *tableVC;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self prepareView];
    
}

#pragma mark -
- (void)prepareView {
    
    
    [self addChildViewController:self.tableVC];
    [self.view addSubview:self.tableVC.tableView];
    [self.view addSubview:self.detailLabel];
    
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.tableVC.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(200);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.tableVC.tableView.mas_top).mas_offset(0);
        make.top.left.right.mas_equalTo(self.view);
    }];
}


#pragma mark - lazy

- (UILabel *)detailLabel {
    
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.text = @"自定义Cell约束Demo";
        _detailLabel.backgroundColor = [UIColor lightGrayColor];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.font = [UIFont systemFontOfSize:16];
        _detailLabel.textColor = [UIColor purpleColor];
    }
    return _detailLabel;
}

- (JSTableViewController *)tableVC {
    
    if (_tableVC == nil) {
        _tableVC = [[JSTableViewController alloc] init];
    }
    return _tableVC;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
