//
//  ViewController.m
//  NSBlockOperation
//
//  Created by ShenYj on 16/8/22.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // [self test1];
    // [self test2];
    // [self test3];
    
    [self test4];
}

// 开辟新线程
- (void)test1{
    
    // 1.创建NSBlockOperation操作对象
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%s-->%@",__func__,[NSThread currentThread]);
    }];
    
    // 2.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 3.将操作添加到队列中
    [queue addOperation:operation];
    
    // LOG: -[ViewController test1]_block_invoke--><NSThread: 0x7fa7c0d3a840>{number = 2, name = (null)}
}

// 不会开辟新线程
- (void)test2{
    
    // 1. 创建NSBlockOperation操作对象
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%s-->%@",__func__,[NSThread currentThread]);
    }];
    
    // 2. 开始执行操作
    [operation start];
    
    // LOG: -[ViewController test2]_block_invoke--><NSThread: 0x7ff50b604f70>{number = 1, name = main}
    
}

// 多个操作调用start方法
- (void)test3{
    
    // 如果操作数大于1,那么大于1的那个操作会开辟一条新的线程成来执行(大于1的多个操作将会开辟几条线程,将由系统决定)
    
    // 1.创建NSBlockOperation操作对象
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%s-->%@",__func__,[NSThread currentThread]);
    }];
    
    // 2.给操作对象添加额外的操作
    [operation addExecutionBlock:^{
        NSLog(@"额外操作-->%@",[NSThread currentThread]);
    }];
    
    // 3. 调用start方法
    [operation start];
    
    /*      LOG:
     
     -[ViewController test3]_block_invoke--><NSThread: 0x7f88527019b0>{number = 1, name = main}

     额外操作--><NSThread: 0x7f885270d590>{number = 2, name = (null)}

     */
}

- (void)test4{
    
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2.添加操作
    [queue addOperationWithBlock:^{
        NSLog(@"%s-->%@",__func__,[NSThread currentThread]);
    }];
    
    // LOG: -[ViewController test4]_block_invoke--><NSThread: 0x7fc6fa700810>{number = 2, name = (null)}
}
@end
