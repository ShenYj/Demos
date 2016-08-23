//
//  ViewController.m
//  自定义Operation取消操作
//
//  Created by ShenYj on 16/8/22.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"
#import "DownloadOperation.h"

@interface ViewController ()

@end

@implementation ViewController{
    
    NSOperationQueue *_queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _queue = [[NSOperationQueue alloc] init];
    _queue.maxConcurrentOperationCount = 3;
    
    for (int i = 0; i < 20; i ++) {
        
        // 1.创建自定义的Operation对象
        DownloadOperation *operation = [DownloadOperation downloadImageUrlString:@"http://t1.mmonly.cc/uploads/tu/201607/tt/1alqhs1gwxo.jpg" completeHandler:^(UIImage *img) {
            NSLog(@"%d --> (%@)",i,[NSThread currentThread]);
        }];
        
        
        // 2.把操作添加到队列中
        [_queue addOperation:operation];
    }
    
}

// 触摸屏幕时取消所有操作(包括正在执行的操作)
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_queue cancelAllOperations];
}

@end
