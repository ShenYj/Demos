//
//  JSAppsTableController.m
//  test
//
//  Created by ShenYj on 2016/10/12.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "JSAppsTableController.h"
#import "NSString+JSCache.h"
#import "JSApps.h"

static NSString * const reuserId = @"123";

@interface JSAppsTableController ()
// 数据容器
@property (nonatomic) NSArray <JSApps *> *appsData;
// 全局队列
@property (nonatomic) NSOperationQueue *queue;
// 操作缓存池
@property (nonatomic) NSMutableDictionary *operationCace;
// 图片缓存池
@property (nonatomic) NSMutableDictionary *imageCache;


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
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd.%@",indexPath.row + 1,app.name];
    
    // 设置占位图
    cell.imageView.image = [UIImage imageNamed:@"user_default.png"];

    // 从图片缓存池获取图片
    if ([self.imageCache objectForKey:app.icon]) {
        
        cell.imageView.image = [self.imageCache objectForKey:app.icon];
        return cell;
    }
    
    // 沙盒获取
    if ([NSData dataWithContentsOfFile:[app.icon cachePath]]) {
        
        NSData *data = [NSData dataWithContentsOfFile:[app.icon cachePath]];
        UIImage *image = [UIImage imageWithData:data];
        
        // 写入内存缓存中
        [self.imageCache setObject:image forKey:app.icon];
        
        NSLog(@"从沙盒获取图片...");
        return cell;
                        
    }
    
    // 避免图片下载操作重复执行
    if ([self.operationCace objectForKey:app.icon]) {
        NSLog(@"图片正在下载...");
        return cell;
    }
    
    // 子线程下载图片
    NSBlockOperation *downloadDownOperation = [NSBlockOperation blockOperationWithBlock:^{
       
        // 模拟延迟
        [NSThread sleepForTimeInterval:3];
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:app.icon]];
        
        UIImage *image = [UIImage imageWithData:data];
        
        // 存入图片缓存池
        [self.imageCache setObject:image forKey:app.icon];
        
        NSString *path = [app.icon cachePath];
        
        [data writeToFile:path atomically:YES];
        
        // 返回主线程刷新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            //cell.imageView.image = image;
            
        }];
        
        
        
    }];
    
    [self.queue addOperation:downloadDownOperation];
    
    [self.operationCace setObject:downloadDownOperation forKey:app.icon];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

#pragma mark - Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%zd",self.queue.operations.count);
}


#pragma mark 
#pragma mark - Lazy
- (NSArray<JSApps *> *)appsData {
    
    if (_appsData == nil) {
        _appsData = [JSApps loadDataWithPlistName:@"apps"];
    }
    return _appsData;
}

- (NSOperationQueue *)queue {
    
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

- (NSMutableDictionary *)operationCace {
    
    if (_operationCace == nil) {
        _operationCace = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return _operationCace;
}

- (NSMutableDictionary *)imageCache {
    
    if (_imageCache == nil) {
        _imageCache = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return _imageCache;
}
@end
