//
//  JSSectionHeaderView.h
//  TableView联动
//
//  Created by ShenYj on 16/8/18.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic,assign) NSInteger data;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
