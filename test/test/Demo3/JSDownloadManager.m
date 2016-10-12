//
//  JSDownloadManager.m
//  test
//
//  Created by ShenYj on 2016/10/12.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "JSDownloadManager.h"
#import "JSApps.h"
#import "JSDownLoadImageOperation.h"
#import "NSString+JSCache.h"

static JSDownloadManager *_instanceType = nil;

@interface JSDownloadManager ()

// 全局队列
@property (nonatomic) NSOperationQueue *queue;
// 操作缓存池
@property (nonatomic) NSMutableDictionary *operationCace;
// 图片缓存池
@property (nonatomic) NSMutableDictionary *imageCache;

@end

@implementation JSDownloadManager

+ (instancetype)sharedManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instanceType = [[self alloc] init];
    });
    return _instanceType;
}

- (void)downLoadWithImageUrlString:(NSString *)urlString completionHandler:(void (^)(UIImage *img))completionHandler {
    
    // 判断是否存在缓存
    if ([self isNotExistWithUrlString:urlString]) {
        
        NSLog(@"缓存中读取图片...");
        UIImage *image = [self.imageCache objectForKey:urlString];
        completionHandler(image);
        
        return ;
    }
    
    // 避免同一张图片下载操作重复执行
    if ([self.operationCace objectForKey:urlString]) {
        NSLog(@"图片正在下载...");
        return ;
    }
    
    __weak typeof(self) weakSelf = self;
    
    
    JSDownLoadImageOperation *downloadDownOperation = [JSDownLoadImageOperation downLoadWithImageUrlString:urlString completionHandler:^(UIImage *img) {
        
        completionHandler(img);
        // 写入内存缓存
        [weakSelf.imageCache setObject:img forKey:urlString];
        // 清除操作缓存池中操作
        [weakSelf.operationCace removeObjectForKey:urlString];
        
    }];
    
    // 添加至队列中
    [self.queue addOperation:downloadDownOperation];
    // 将下载操作添加至操作缓存池中
    [self.operationCace setObject:downloadDownOperation forKey:urlString];
}

- (BOOL)isNotExistWithUrlString:(NSString *)urlString {
    
    // 判断是否存在内存缓存
    if ([self.imageCache objectForKey:urlString]) {
        
        return YES;
    }
    
    // 判断是否存在沙盒缓存
    if ([NSData dataWithContentsOfFile:[urlString cachePath]]) {
        
        NSData *data = [NSData dataWithContentsOfFile:[urlString cachePath]];
        UIImage *image = [UIImage imageWithData:data];
        [self.imageCache setObject:image forKey:urlString];
        
        return YES;
    }
    
    return NO;
}
- (void)cancelOperationWithUrlString:(NSString *)urlString {
    
    if (urlString == nil) {
        return ;
    }
    
    [[self.operationCace objectForKey:urlString] cancel];
    
    [self.operationCace removeObjectForKey:urlString];
    
}



#pragma mark
#pragma mark - Lazy

- (NSOperationQueue *)queue {
    
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 6;
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
