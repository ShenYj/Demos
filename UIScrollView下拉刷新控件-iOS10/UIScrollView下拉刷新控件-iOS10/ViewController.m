//
//  ViewController.m
//  UIScrollView下拉刷新控件-iOS10
//
//  Created by ShenYj on 2017/1/13.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) UIRefreshControl *refreshControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor greenColor];
    
    // 1.实例化ScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    
    // 2.实例化View,作为ScrollView的子视图
    UIView *blueView = [[UIView alloc] init];
    blueView.frame = CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height);
    blueView.backgroundColor = [UIColor blueColor];
    [scrollView addSubview:blueView];
    
    // 3. 设置滚动区域,使ScrollView能够滚动
    scrollView.contentSize = CGSizeMake(0, blueView.bounds.size.height + 1);
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    [scrollView addSubview:self.refreshControl];
}


- (void)refreshData {
    NSLog(@"%s",__func__);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
