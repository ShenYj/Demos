//
//  JSBaseViewController.m
//  iPhoneXAdapterDemo
//
//  Created by ecg on 2017/11/10.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSBaseViewController.h"

@interface JSBaseViewController ()

@end

@implementation JSBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection
{
//    NSLog(@"%s",__func__);
}

- (void)viewSafeAreaInsetsDidChange
{
    [super viewSafeAreaInsetsDidChange];
//    NSLog(@"%s",__func__);
}

@end
