//
//  JSSectionHeaderView.m
//  TableView联动
//
//  Created by ShenYj on 16/8/18.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSSectionHeaderView.h"
#import "JSUIkitExtension.h"

static NSString * const headerReuseId = @"header";

@implementation JSSectionHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView{
    
    JSSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerReuseId];
    
    if (!headerView) {
        headerView = [[JSSectionHeaderView alloc] initWithReuseIdentifier:headerReuseId];
    }
    
    return headerView;

}


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
    }
    return self;
}

- (void)setData:(NSInteger)data{
    _data = data;
    
    self.textLabel.text = [NSString stringWithFormat:@"第%zd组",data];
}

@end
