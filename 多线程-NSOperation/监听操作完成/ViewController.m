//
//  ViewController.m
//  监听操作完成
//
//  Created by ShenYj on 16/8/22.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    
    NSOperationQueue *_queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 实例化队列
    _queue = [[NSOperationQueue alloc] init];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // 2.创建操作对象
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        
        for (int i = 0; i < 20; i ++) {
            
            NSLog(@"Operation");
        }
    }];
    
    // 监听操作是否完成
    [operation setCompletionBlock:^{
        // 操作执行完毕后需要执行的操作
        NSLog(@"Operation执行完毕");
    }];
    
    // 3.将两个操作添加到队列中
    [_queue addOperation:operation];
}

@end
