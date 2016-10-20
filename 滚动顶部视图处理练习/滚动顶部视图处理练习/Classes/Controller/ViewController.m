//
//  ViewController.m
//  滚动顶部视图处理练习
//
//  Created by ShenYj on 2016/10/20.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "ViewController.h"
#import "JSTableView.h"

@interface ViewController ()

@property (nonatomic) JSTableView *headerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.headerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 
#pragma mark - Lazy

- (JSTableView *)headerView {
    
    if (_headerView == nil) {
        _headerView = [[JSTableView alloc] init];
    }
    return _headerView;
}

@end
