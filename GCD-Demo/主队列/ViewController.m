//
//  ViewController.m
//  主队列
//
//  Created by ShenYj on 16/8/20.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

// 主队列与同步/异步
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 异步执行
    // [self mainQueueAsync];
    
    // 同步执行
    // [self mainQueueSync]; --> 死锁
    [self mainQueueSyncTask]; // -> 主队列同步执行任务(解决死锁)
}

// 主队列异步
- (void)mainQueueAsync{
    
    // 1.获取队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    // 2.创建任务
    dispatch_block_t task1Block = ^{
        
        [NSThread sleepForTimeInterval:5];
        NSLog(@"Task1-->%@",[NSThread currentThread]);
    };
    
    dispatch_block_t task2Block = ^{
        NSLog(@"Task2-->%@",[NSThread currentThread]);
    };
    
    // 3.异步执行任务
    dispatch_async(mainQueue, task1Block);
    dispatch_async(mainQueue, task2Block);
    
    // 结论: 同步执行,不开启新线程 (注意点:主队列的任务一定是在主线程执行,而自行创建的串行队列是在当前线程来执行)
    
}
// 主队列同步 (解决死锁)
- (void)mainQueueSyncTask{
    
    NSLog(@"Begin");
    
    // 将主队列同步任务放入一条子线程中异步执行,因为主队列任务会在主线程执行,所以并不影响主队列中的任务在主线程执行
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 1.获取队列
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        
        // 2.创建任务
        dispatch_block_t task1Block = ^{
            
            [NSThread sleepForTimeInterval:5];
            NSLog(@"Task1-->%@",[NSThread currentThread]);
        };
        
        dispatch_block_t task2Block = ^{
            NSLog(@"Task2-->%@",[NSThread currentThread]);
        };
        
        // 3.异步执行任务
        dispatch_sync(mainQueue, task1Block); // 程序会一致卡在这句代码-->主队列同步执行导致死锁
        dispatch_sync(mainQueue, task2Block);
        
    });
    
    NSLog(@"End");
    
    // 结果: 死锁
}

// 主队列同步 (死锁)
- (void)mainQueueSync{
    
    NSLog(@"Begin");
    
    // 1.获取队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    // 2.创建任务
    dispatch_block_t task1Block = ^{
        
        [NSThread sleepForTimeInterval:5];
        NSLog(@"Task1-->%@",[NSThread currentThread]);
    };
    
    dispatch_block_t task2Block = ^{
        NSLog(@"Task2-->%@",[NSThread currentThread]);
    };
    
    // 3.同步执行任务
    dispatch_sync(mainQueue, task1Block); // 程序会一致卡在这句代码-->主队列同步执行导致死锁
    dispatch_sync(mainQueue, task2Block);
    
    NSLog(@"End");
    
    // 结果: 死锁
}

@end
