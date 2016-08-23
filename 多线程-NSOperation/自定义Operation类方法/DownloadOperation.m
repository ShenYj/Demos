//
//  DownloadOperation.m
//  多线程-NSOperation
//
//  Created by ShenYj on 16/8/22.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "DownloadOperation.h"


@implementation DownloadOperation

- (void)main{
    
    NSAssert(self.completeHandler != nil, @"completeHandler == nil");
    
    // 下载图片
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlString]];
    UIImage *image = [UIImage imageWithData:data];
    
    // 返回主线程刷新UI
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        self.completeHandler(image);
    }];
}

// 自定义类方法下载图片

+ (instancetype)downloadImageUrlString:(NSString *)urlString completeHandler:(void (^)(UIImage *))completeHandler{
    
    DownloadOperation *operation = [[DownloadOperation alloc] init];
    operation.urlString = urlString;
    operation.completeHandler = completeHandler;
    return operation;
    
}

@end
