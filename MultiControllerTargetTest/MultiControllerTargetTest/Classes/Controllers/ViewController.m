//
//  ViewController.m
//  MultiControllerTargetTest
//
//  Created by ShenYj on 2017/1/19.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) UITableViewController *tableViewController;
@property (nonatomic) UIViewController *viewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self prepareView];
}

- (void)prepareView {
    
    [self addChildViewController:self.tableViewController];
    [self addChildViewController:self.viewController];
    
    [self.view addSubview:self.tableViewController.tableView];
    [self.view addSubview:self.viewController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark
#pragma mark - lazy

- (UITableViewController *)tableViewController {
    if (!_tableViewController) {
        _tableViewController = [[UITableViewController alloc] init];
        _tableViewController.view.frame = CGRectMake(0, 0, 100, [UIScreen mainScreen].bounds.size.height);
        _tableViewController.view.backgroundColor = [UIColor redColor];
    }
    return _tableViewController;
}

- (UIViewController *)viewController {
    if (!_viewController) {
        _viewController = [[UIViewController alloc] init];
        _viewController.view.backgroundColor = [UIColor blueColor];
        _viewController.view.frame = CGRectMake(100, 0, [UIScreen mainScreen].bounds.size.height - 100, [UIScreen mainScreen].bounds.size.height);
    }
    return _viewController;
}

@end
