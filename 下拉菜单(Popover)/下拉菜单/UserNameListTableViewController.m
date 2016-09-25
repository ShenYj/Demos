//
//  UserNameListTableViewController.m
//  下拉菜单
//
//  Created by ShenYj on 16/9/22.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "UserNameListTableViewController.h"

static NSString *reuseId = @"reuse";

@interface UserNameListTableViewController ()

@end

@implementation UserNameListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"laowang%zd",indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    //cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark - Table view delegate 

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (self.selectedHandler) {
        self.selectedHandler(cell.textLabel.text);
    }
}

@end
