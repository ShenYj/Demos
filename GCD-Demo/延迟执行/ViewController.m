//
//  ViewController.m
//  延迟执行
//
//  Created by ShenYj on 16/8/21.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"begin");
    
    // 延迟执行
    /*
        参数1: <#delayInSeconds#>   --> 延迟多少时间执行
        参数2: dispatch_queue_t  --> 执行操作的队列
        参数3: dispatch_block_t  --> 执行的任务
        异步执行,并不会卡死主线程
     */
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"%s-->(%@)",__func__,[NSThread currentThread]);
    });
    
    NSLog(@"end");
    
}

@end
