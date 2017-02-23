//
//  ViewController.m
//  TableView内嵌ScrollView测试
//
//  Created by ShenYj on 2017/2/20.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "ViewController.h"
#import "JSTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    JSTableViewController *tableViewController = [[JSTableViewController alloc] init];
    [self.navigationController pushViewController:tableViewController animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
