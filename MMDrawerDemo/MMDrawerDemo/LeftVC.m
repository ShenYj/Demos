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
    
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        PushedVC *pushedVC = [[PushedVC alloc] init];
        UINavigationController *Nav = (UINavigationController *)self.mm_drawerController.centerViewController;
        [Nav pushViewController:pushedVC animated:YES];
    }];
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
