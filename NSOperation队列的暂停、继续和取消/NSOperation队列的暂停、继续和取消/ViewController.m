//
//  ViewController.m
//  NSOperation队列的暂停、继续和取消
//
//  Created by ShenYj on 16/8/22.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    
    NSOperationQueue *_queue; // 全局队列
}

// 取消 : 只能够暂停还没执行的操作,正在执行的操作不能够暂停
- (IBAction)clickCancelButton:(id)sender {
    
    [_queue cancelAllOperations];// 取消所有操作
    NSLog(@"取消全部操作(队列操作数:%zd)",_queue.operationCount);
}

// 暂停 : 只能够暂停还没执行的操作,正在执行的操作不能够暂停
- (IBAction)clickSuspendButton:(id)sender {
    
    _queue.suspended = YES;// 暂停操作
    NSLog(@"操作暂停(队列操作数:%zd)",_queue.operationCount);
}

// 继续
- (IBAction)clickResumeButton:(id)sender {
    
    _queue.suspended = NO;// 继续操作
    NSLog(@"继续操作(队列操作数:%zd)",_queue.operationCount);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 实例化队列对象
    _queue = [[NSOperationQueue alloc] init];
    
    // 设置最大并发数 :同一时间执行的操作数目
    _queue.maxConcurrentOperationCount = 3;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // 通过for循环模拟20个操作
    for (int i = 0; i < 20; i ++) {
        
        // 异步执行操作
        [_queue addOperationWithBlock:^{
            
            [NSThread sleepForTimeInterval:3];
            NSLog(@"%d-->%@",i,[NSThread currentThread]);
        }];
    }
}

@end
