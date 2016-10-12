//
//  JSDownLoadImageOperation.m
//  test
//
//  Created by ShenYj on 2016/10/12.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "JSDownLoadImageOperation.h"
#import "NSString+JSCache.h"

@interface JSDownLoadImageOperation ()


@end

@implementation JSDownLoadImageOperation

- (void)main {
    
    NSLog(@"%@",[NSThread currentThread]);
    
    // 模拟延迟
    [NSThread sleepForTimeInterval:3];
    
    NSAssert(self.finishBlock != nil, @"finishBlock为空!");
    
    NSURL *url = [NSURL URLWithString:self.imageURL];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    // 写入沙盒
    NSString *path = [self.imageURL.lastPathComponent cachePath];
    
    [data writeToFile:path atomically:YES];
    
    if (self.isCancelled) {
        return ;
    }
    
    UIImage *image = [UIImage imageWithData:data];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
       
        self.finishBlock(image);
    }];
    
}

+ (instancetype)downLoadWithImageUrlString:(NSString *)urlString completionHandler:(void (^)(UIImage *))completionHandler {
    
    JSDownLoadImageOperation *downloadDownOperation = [[JSDownLoadImageOperation alloc] init];
    downloadDownOperation.imageURL = urlString;
    downloadDownOperation.finishBlock = completionHandler;
    
    return downloadDownOperation;
    
}


@end
