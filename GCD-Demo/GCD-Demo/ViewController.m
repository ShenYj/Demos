//
//  ViewController.m
//  GCD-Demo
//
//  Created by ShenYj on 16/8/20.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 队列 (这里获取的是系统提供的全局队列,一个并发队列,后续会对队列单独讲解)
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    // 任务
    dispatch_block_t task = ^{
        NSLog(@"任务-->(%@)",[NSThread currentThread]);
    };
    
    /*
         执行任务:
            参数1: 队列
            参数2: 任务
     */
    // 异步处理
    dispatch_async(queue, task);
    
    // 同步处理: dispatch_sync(queue, task);
    
}

- (void)demo{
    
    // 异步处理任务
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"任务-->(%@)",[NSThread currentThread]);
    });
}

@end
