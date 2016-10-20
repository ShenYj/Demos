//
//  ViewController.m
//  滚动顶部视图处理练习
//
//  Created by ShenYj on 2016/10/20.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "ViewController.h"
#import "JSHeaderViewController.h"


@interface ViewController () 


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self prepareNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)prepareNavigationBar {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Demo" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBarButtonItem:)];
}

- (void)clickRightBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    JSHeaderViewController *headerVC = [[JSHeaderViewController alloc] init];
    [self.navigationController pushViewController:headerVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
