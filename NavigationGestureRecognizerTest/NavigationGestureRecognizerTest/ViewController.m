//
//  ViewController.m
//  NavigationGestureRecognizerTest
//
//  Created by ShenYj on 2017/3/7.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"v2_goback"] forState:UIControlStateNormal];
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
