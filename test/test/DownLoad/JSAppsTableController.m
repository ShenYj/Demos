//
//  JSAppsTableController.m
//  test
//
//  Created by ShenYj on 2016/10/12.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "JSAppsTableController.h"
#import "JSApps.h"

static NSString * const reuserId = @"123";

@interface JSAppsTableController ()

@property (nonatomic) NSArray <JSApps *> *appsData;

@end

@implementation JSAppsTableController

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
    
    cell.textLabel.text = app.name;
    
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:app.icon]];
    cell.imageView.image = [UIImage imageWithData:data];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
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
