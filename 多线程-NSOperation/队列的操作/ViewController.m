//
//  ViewController.m
//  队列的操作
//
//  Created by ShenYj on 16/8/22.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    
    NSOperationQueue *_queue; // 全局队列
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 实例化队列对象
    _queue = [[NSOperationQueue alloc] init];
    
    // 设置最大并发数 :同一时间执行的操作数目
    _queue.maxConcurrentOperationCount = 3;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // 通过for循环模拟20个操作
    for (int i = 0; i < 20; i ++) {
        
        // 异步执行操作
        [_queue addOperationWithBlock:^{
            
            [NSThread sleepForTimeInterval:3];
            NSLog(@"%d-->%@",i,[NSThread currentThread]);
        }];
    }
}

@end
