//
//  JSAppsTableViewController.m
//  test
//
//  Created by ShenYj on 2016/10/12.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "JSAppsTableViewController.h"
#import "UIImageView+JSWebCache.h"


static NSString * const reuserId = @"123";


@interface JSAppsTableViewController ()

// 数据容器
@property (nonatomic) NSArray <JSApps *> *appsData;

@property (nonatomic,copy) NSString *currentString;

@end

@implementation JSAppsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareTableView];
    
}

- (void)prepareTableView {
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuserId];
}



#pragma mark
#pragma mark - DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.appsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JSApps *app = self.appsData[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserId forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd.%@",indexPath.row + 1,app.name];
    
    [cell.imageView js_setImageWithUrlString:app.icon withPlaceHolderImage:[UIImage imageNamed:@"user_default.png"]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}




#pragma mark
#pragma mark - Lazy
- (NSArray<JSApps *> *)appsData {
    
    if (_appsData == nil) {
        _appsData = [JSApps loadDataWithPlistName:@"apps"];
    }
    return _appsData;
}

@end
