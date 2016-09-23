//
//  UserNameListTableViewController.h
//  下拉菜单
//
//  Created by ShenYj on 16/9/22.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserNameListTableViewController : UITableViewController

@property (nonatomic,copy) void (^selectedHandler)(NSString *userName);

@end
