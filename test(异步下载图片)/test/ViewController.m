//
//  ViewController.m
//  test
//
//  Created by ShenYj on 2016/10/12.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "ViewController.h"
#import "JSAppsTableController.h"
#import "JSAppsTableViewController.h"

@interface ViewController ()

//@property (nonatomic) JSAppsTableController *appsTable;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"demo2" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBarButtonItem:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"demo1" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBarButtonItem:)];
}

- (void)clickRightBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    JSAppsTableController *appsTable = [[JSAppsTableController alloc] init];
    [self.navigationController pushViewController:appsTable animated:YES];
    
}

- (void)clickLeftBarButtonItem:(UIBarButtonItem *)barButtonItem {
    JSAppsTableViewController *appsTable = [[JSAppsTableViewController alloc] init];
    [self.navigationController pushViewController:appsTable animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
