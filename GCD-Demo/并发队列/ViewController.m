//
//  ViewController.m
//  并发队列
//
//  Created by ShenYj on 16/8/20.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark -- 并行队列与同步、异步的组合
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 同步执行
    // [self concurrentSync];
    // 异步执行
    [self concurrentAsync];
}

#pragma mark -- 并行同步
- (void)concurrentSync{
    
    // 同步
    
    // 1.创建并行队列
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    // 2.创建任务
    dispatch_block_t taskBlock1 = ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"Task1-->%@",[NSThread currentThread]);
    };
    dispatch_block_t taskBlock2 = ^{
        NSLog(@"Task2-->%@",[NSThread currentThread]);
    };
    
    // 同步执行
    dispatch_sync(concurrentQueue, taskBlock1);
    dispatch_sync(concurrentQueue, taskBlock2);
    
    // 结论: 在当前的线程执行(同步不具备开启新线程能力),任务依次执行
}
#pragma mark -- 并行异步
- (void)concurrentAsync{
    
    // 异步
    
    // 1.创建并行队列
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    // 2.创建任务
    dispatch_block_t taskBlock1 = ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"Task1-->%@",[NSThread currentThread]);
    };
    dispatch_block_t taskBlock2 = ^{
        NSLog(@"Task2-->%@",[NSThread currentThread]);
    };
    
    // 异步执行(每添加一个任务就开启一条线程)
    dispatch_async(concurrentQueue, taskBlock1);
    dispatch_async(concurrentQueue, taskBlock2);
    
    // 结论: 开启线程执行任务(根据添加的任务开启多条线程),任务并行处理(没有按照添加到队列中的顺序来执行)
}

@end
