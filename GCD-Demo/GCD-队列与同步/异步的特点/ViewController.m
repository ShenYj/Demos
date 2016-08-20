//
//  ViewController.m
//  GCD-队列与同步/异步的特点
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
    /*
     
     #####GCD的队列可以分为2大类型#####
        - 1.并发队列（Concurrent Dispatch Queue）
            可以让多个任务并发（同时）执行（自动开启多个线程同时执行任务）
            并发功能只有在异步（dispatch_async）函数下才有效
        - 2.串行队列（Serial Dispatch Queue）
            让任务一个接着一个地执行（一个任务执行完毕后，再执行下一个任务）
     
     
     #####同步和异步决定了要不要开启新的线程#####
        1.同步：在当前线程中执行任务，不具备开启新线程的能力
        2.异步：在新的线程中执行任务，具备开启新线程的能力
     
     #####并发和串行决定了任务的执行方式#####
        1.并发：多个任务并发（同时）执行
        2.串行：一个任务执行完毕后，再执行下一个任务
     
     */
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
}

@end
