//
//  JSMenumTableView.m
//  TableView联动
//
//  Created by ShenYj on 16/8/18.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSMenumTableView.h"
#import "JSUIkitExtension.h"
#import "JSSectionHeaderView.h"


static NSString * const reuseID = @"menum";

@implementation JSMenumTableView


- (instancetype)initWithStyle:(UITableViewStyle)style{
    
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
        // 准备视图
        [self prepareView];
        
    }
    return self;
}

// 准备视图
- (void)prepareView{
    
    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseID];
    
}



#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%zd组第%@行",indexPath.section,[NSNumber numberWithInteger:indexPath.row].stringValue];
    
    
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

// 组头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    JSSectionHeaderView *headerView = [JSSectionHeaderView headerViewWithTableView:tableView];
    
    headerView.data = section;

    
    return headerView;
}

// 点击Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.ClickMenumCell) {
        self.ClickMenumCell(indexPath);
    }
}

@end
