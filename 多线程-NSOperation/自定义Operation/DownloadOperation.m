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
    
    //@autoreleasepool {
    // 更新后不再需要手动创建,系统内部做过优化
    //}
    NSAssert(self.completeHandler != nil, @"completeHandler == nil");
    
    // 下载图片
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlString]];
    UIImage *image = [UIImage imageWithData:data];
    
    // 返回主线程刷新UI
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
       
        self.completeHandler(image);
    }];
}

@end
