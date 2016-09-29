//
//  JSTableViewController.m
//  layoutConstraintTest
//
//  Created by ShenYj on 16/9/29.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSTableViewController.h"
#import "JSTableViewCell.h"



static NSString * const reuseID = @"reuseIdentifier";

@interface JSTableViewController ()

@end

@implementation JSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[JSTableViewCell class] forCellReuseIdentifier:reuseID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    
    cell.textLabel.text = @(indexPath.row).description;
    
    return cell;
}



@end
