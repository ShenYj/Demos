//
//  ViewController.m
//  MMDrawerDemo
//
//  Created by ShenYj on 2016/11/28.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+MMDrawerController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor purpleColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"左侧按钮" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBarButtonItem:)];
}

- (void)clickLeftBarButtonItem:(UIBarButtonItem *)sender {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
        
    }];
}

- (NSString *)title {
    return @"首页";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
