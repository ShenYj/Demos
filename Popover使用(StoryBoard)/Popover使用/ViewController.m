//
//  ViewController.m
//  Popover使用
//
//  Created by ShenYj on 16/9/22.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIPopoverPresentationControllerDelegate>

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self prepareView];
}

- (void)prepareView {
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // 通过segue获取目标控制器
    UIViewController *destination = segue.destinationViewController;
    // 设置PreferredContentSize
    destination.preferredContentSize = CGSizeMake(100, 200);
    // 获取Popover对象
    UIPopoverPresentationController *popover = destination.popoverPresentationController;
    // 设置代理
    popover.delegate = self;
    
    // 判断Popover的响应控件是UIBarButtonItem或来源视图
    if ([segue.identifier isEqualToString:@"button"]) {
        
        UIButton *button = (UIButton *)sender;
        popover.sourceRect = button.bounds;
        
    } else if ([segue.identifier isEqualToString:@"item"]){
        
        
    }
    
    
}

#pragma mark - UIAdaptivePresentationControllerDelegate
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    
    return UIModalPresentationNone;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
