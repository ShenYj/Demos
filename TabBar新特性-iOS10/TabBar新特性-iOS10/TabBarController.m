//
//  TabBarController.m
//  TabBar新特性-iOS10
//
//  Created by ShenYj on 2017/2/8.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.unselectedItemTintColor = [UIColor blackColor];
    self.tabBar.tintColor = [UIColor purpleColor];
//    for (UIViewController *viewController in self.childViewControllers) {
//        [viewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateNormal];
//        [viewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor purpleColor]} forState:UIControlStateSelected];
//    }
    
    self.tabBar.items[1].badgeColor = [UIColor blackColor];
    self.tabBar.items[1].badgeValue = @"10";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
