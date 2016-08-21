//
//  ViewController.m
//  调度组的原理
//
//  Created by ShenYj on 16/8/21.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

// 调度组的原理
/*!
 * @function dispatch_group_enter
 *
 * @abstract
 * Manually indicate a block has entered the group
 *
 * @discussion
 * Calling this function indicates another block has joined the group through
 * a means other than dispatch_group_async(). Calls to this function must be
 * balanced with dispatch_group_leave().
 *
 * @param group
 * The dispatch group to update.
 * The result of passing NULL in this parameter is undefined.
 */
- (void)demo{
    
    // 创建调度组
    dispatch_group_t group = dispatch_group_create();
    
    // 相当于任务1
    // 将后面的代码放入调度组中执行
    dispatch_group_enter(group);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"操作1");
        //任务执行完毕后离开调度组
        dispatch_group_leave(group);
    });
    
    // 相当于任务2
    dispatch_group_enter(group);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:3];
        dispatch_group_leave(group);
        NSLog(@"操作2");
    });
    
    // 相当于任务3
    dispatch_group_enter(group);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"操作3");
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"任务执行完毕");
    });
    
    
}


// 调度组的使用
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
