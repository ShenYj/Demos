//
//  JSTsbBarController.m
//  iPhoneXAdapterDemo
//
//  Created by ecg on 2017/11/10.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSTsbBarController.h"
#import "JSBaseViewController.h"
#import "JSHomeViewController.h"

@interface JSTsbBarController ()

@end

@implementation JSTsbBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildBaseController:[[JSHomeViewController alloc] init] title:@"首页"];
    [self addChildBaseController:[[JSBaseViewController alloc] init] title:@"搜索"];
    [self addChildBaseController:[[JSBaseViewController alloc] init] title:@"其他"];
    [self addChildBaseController:[[JSBaseViewController alloc] init] title:@"我的"];
}

- (void)addChildBaseController:(JSBaseViewController *)controller title:(NSString *)title
{
    UINavigationController *navgationController = [[UINavigationController alloc] initWithRootViewController:controller];
    navgationController.title = title;
    controller.title = title;
    [self addChildViewController:navgationController];
}


@end
