//
//  JSDetailTableView.m
//  TableView联动
//
//  Created by ShenYj on 16/8/18.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSDetailTableView.h"
#import "JSUIkitExtension.h"
#import "JSSectionHeaderView.h"

static NSString * const reuseID = @"detail";

@implementation JSDetailTableView


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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%zd组第%@行",indexPath.section,[NSNumber numberWithInteger:indexPath.row].stringValue];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

// 组头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    JSSectionHeaderView *headerView = [JSSectionHeaderView headerViewWithTableView:tableView];
    
    headerView.data = section;
    
    
    return headerView;
}

// 滚动视图停止时

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    UITableViewCell *firstVisibleCell = self.tableView.visibleCells.firstObject;
    NSIndexPath *firstCellIndexPath = [self.tableView indexPathForCell:firstVisibleCell];
    
    if (self.scrollDetailCell) {
        self.scrollDetailCell(firstCellIndexPath);
    }
}

@end
