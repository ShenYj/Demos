//
//  JSDetailTableView.h
//  TableView联动
//
//  Created by ShenYj on 16/8/18.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSDetailTableView : UITableViewController

@property (nonatomic,copy) void(^scrollDetailCell)(NSIndexPath *indexPath);

@end
