//
//  ViewController.m
//  串行队列
//
//  Created by ShenYj on 16/8/20.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark -- 串行队列与同步、异步的组合
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 串行异步执行
    // [self serialAsync];
    [self serialSync];
}

#pragma mark -- 串行异步处理
- (void)serialAsync{
    
    /*   队列
           参数1: <#const char *label#>          -->队列的名称
           参数2: <#dispatch_queue_attr_t attr#> -->队列的属性 DISPATCH_QUEUE_SERIAL(串行)
     */
    dispatch_queue_t serialQueue = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
    
    //   任务
    dispatch_block_t taskBlock1 = ^{
        
        // 延迟的意图在于演示多任务在串行队列中依次执行(FIFO原则)
        [NSThread sleepForTimeInterval:5];
        NSLog(@"Task1-->%@",[NSThread currentThread]);
    };
    dispatch_block_t taskBlock2 = ^{
        NSLog(@"Task2-->%@",[NSThread currentThread]);
    };
    
    dispatch_async(serialQueue, taskBlock1);
    dispatch_async(serialQueue, taskBlock2);
    
    // 结论:异步执行开启了新线程(只开启了一条),任务依次执行(串行队列)
}

#pragma mark -- 串行同步处理
- (void)serialSync{
    
    //   队列
    dispatch_queue_t serialQueue = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
    
    //   任务
    dispatch_block_t taskBlock1 = ^{
        
        // 延迟的意图在于演示多任务在串行队列中依次执行(FIFO原则)
        [NSThread sleepForTimeInterval:5];
        NSLog(@"Task1-->%@",[NSThread currentThread]);
    };
    dispatch_block_t taskBlock2 = ^{
        NSLog(@"Task2-->%@",[NSThread currentThread]);
    };
    
    dispatch_sync(serialQueue, taskBlock1);
    dispatch_sync(serialQueue, taskBlock2);
    
    // 结论:同步执行没有开启新线程,任务依次执行
}

@end
