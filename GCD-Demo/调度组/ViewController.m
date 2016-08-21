//
//  ViewController.m
//  调度组
//
//  Created by ShenYj on 16/8/21.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
// 调度组使用

// 需求: 任务1&任务2&任务3 --> 全部都完成后(不限制执行顺序),提示完成
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    // 1.需要执行的任务
    dispatch_block_t task1 = ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"操作1");
    };
    dispatch_block_t task2 = ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"操作2");
    };
    dispatch_block_t task3 = ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"操作3");
    };
    
    // 2.创建调度组
    dispatch_group_t group = dispatch_group_create();
    
    // 3.添加到调度组中
    /*    dispatch_group_async(<#dispatch_group_t group#>, <#dispatch_queue_t queue#>, <#^(void)block#>)
            参数1:<#dispatch_group_t group#>  -> 调度组
            参数2:<#dispatch_queue_t queue#>  -> 队列(处理任务执行的队列)
            参数3:<#^(void)block#>            -> 任务
     */
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), task1);
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), task2);
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), task3);
    
    // 4.调度组内的任务执行完毕后回到主线程通知
    /*     dispatch_group_notify(<#dispatch_group_t group#>, <#dispatch_queue_t queue#>, <#^(void)block#>)
             参数1:<#dispatch_group_t group#>  -> 调度组
             参数2:<#dispatch_queue_t queue#>  -> 队列(参数3内的代码执行队列)
             参数3:<#^(void)block#>            -> 任务
     
     */
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"执行完毕");
    });
}

@end
