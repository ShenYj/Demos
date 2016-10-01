//
//  JSSQLTableViewController.h
//  SQL
//
//  Created by ShenYj on 16/9/30.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSStudent.h"

@interface JSSQLTableViewController : UITableViewController

@property (nonatomic) NSArray <JSStudent *> *queryData;

- (instancetype)initWithStyle:(UITableViewStyle)style withData:(NSArray <JSStudent *>*)data;

@end
