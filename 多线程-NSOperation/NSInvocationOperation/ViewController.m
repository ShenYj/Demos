//
//  ViewController.m
//  NSInvocationOperation
//
//  Created by ShenYj on 16/8/22.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
     [self test1];
    // [self test2];
}
// 开辟新线程
- (void)test1{
    
    // 1.创建操作对象
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(demo) object:nil];
    
    // 2.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 3.将操作对象添加到队列中
    [queue addOperation:operation];
    
    // LOG: -[ViewController demo]--><NSThread: 0x7fecf0c01020>{number = 2, name = (null)}
}

// 没有开辟新线程
- (void)test2{
    
    // 1.创建操作对象
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(demo) object:nil];
    
    // 2.开始执行操作
    [operation start];
    
    // LOG:  -[ViewController demo]--><NSThread: 0x7fbcf2604e80>{number = 1, name = main}

}

// 被调用的方法
- (void)demo{
    
    NSLog(@"%s-->%@",__func__,[NSThread currentThread]);
}

@end
