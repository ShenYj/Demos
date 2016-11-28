//
//  LeftVC.m
//  MMDrawerDemo
//
//  Created by ShenYj on 2016/11/28.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "LeftVC.h"
#import "PushedVC.h"
#import "UIViewController+MMDrawerController.h"

@interface LeftVC ()

@property (nonatomic,strong) UIButton *button;

@end

@implementation LeftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.button];
    
}

- (void)clickPushViewControllerButton:(UIButton *)sender {
    
    // 默认是先收起左侧控制器,中央控制器回到屏幕中央的同时再去Push控制器
    //[self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
    //}];
    
    PushedVC *pushedVC = [[PushedVC alloc] init];
    
    // 基于原有方法,添加一个控制器参数,获取到中央控制器先进行Push操作,然后再收起左侧控制器
    [self.mm_drawerController closeDrawerAnimated:YES TempVc:pushedVC completion:nil];
}

- (UIButton *)button {
    if (!_button) {
        _button = [[UIButton alloc] init];
        _button.titleLabel.font = [UIFont systemFontOfSize:15];
        [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_button setBackgroundColor:[UIColor whiteColor]];
        [_button setTitle:@"push新控制器" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(clickPushViewControllerButton:) forControlEvents:UIControlEventTouchUpInside];
        _button.frame = CGRectMake(50, 20, 100, 44);

    }
    return _button;
}


@end
