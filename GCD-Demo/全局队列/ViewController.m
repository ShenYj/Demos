//
//  ViewController.m
//  全局队列
//
//  Created by ShenYj on 16/8/20.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


/*!
 * @function dispatch_get_global_queue
 *
 * @abstract
 * Returns a well-known global concurrent queue of a given quality of service
 * class.
 *
 * @discussion
 * The well-known global concurrent queues may not be modified. Calls to
 * dispatch_suspend(), dispatch_resume(), dispatch_set_context(), etc., will
 * have no effect when used with queues returned by this function.
 *
 * @param identifier
 * A quality of service class defined in qos_class_t or a priority defined in
 * dispatch_queue_priority_t.
 *
 * It is recommended to use quality of service class values to identify the
 * well-known global concurrent queues:
 *  - QOS_CLASS_USER_INTERACTIVE
 *  - QOS_CLASS_USER_INITIATED
 *  - QOS_CLASS_DEFAULT
 *  - QOS_CLASS_UTILITY
 *  - QOS_CLASS_BACKGROUND
 *
 * The global concurrent queues may still be identified by their priority,
 * which map to the following QOS classes:
 *  - DISPATCH_QUEUE_PRIORITY_HIGH:         QOS_CLASS_USER_INITIATED
 *  - DISPATCH_QUEUE_PRIORITY_DEFAULT:      QOS_CLASS_DEFAULT
 *  - DISPATCH_QUEUE_PRIORITY_LOW:          QOS_CLASS_UTILITY
 *  - DISPATCH_QUEUE_PRIORITY_BACKGROUND:   QOS_CLASS_BACKGROUND
 *
 * @param flags
 * Reserved for future use. Passing any value other than zero may result in
 * a NULL return value.
 *
 * @result
 * Returns the requested global queue or NULL if the requested global queue
 * does not exist.
 */

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 同步执行
    // [self globalQueueSync];
    // 异步执行
    [self globalQueueAsync];
}

#pragma mark -- 全局队列同步执行
- (void)globalQueueSync{
    
    // 1.获取全局队列
    /*
       参数说明:
           参数1: <#long identifier#>     --> 优先级
           参数2: <#unsigned long flags#> --> 未来使用,预留参数
     */
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    
    // 2.创建任务
    dispatch_block_t task1Block = ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"Task1-->%@",[NSThread currentThread]);
    };
    dispatch_block_t task2Block = ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"Task2-->%@",[NSThread currentThread]);
    };
    
    // 3.同步执行
    dispatch_sync(globalQueue, task1Block);
    dispatch_sync(globalQueue, task2Block);
    
    // 结论: 在当前的线程执行(同步不具备开启新线程能力),任务依次执行-->(与并发队列一致)
}

#pragma mark -- 全局队列异步执行
- (void)globalQueueAsync{
    
    // 1.获取全局队列
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    
    // 2.创建任务
    dispatch_block_t task1Block = ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"Task1-->%@",[NSThread currentThread]);
    };
    dispatch_block_t task2Block = ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"Task2-->%@",[NSThread currentThread]);
    };
    
    // 3.异步执行
    dispatch_async(globalQueue, task1Block);
    dispatch_async(globalQueue, task2Block);
    
    // 结论: 开启线程执行任务(根据添加的任务开启多条线程),任务并行处理(没有按照添加到队列中的顺序来执行)-->(与并发队列一致)
}

@end
