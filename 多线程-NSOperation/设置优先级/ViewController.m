//
//  ViewController.m
//  设置优先级
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
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        
        for (int i = 0; i < 20; i ++) {
            
            NSLog(@"Operation1");
        }
    }];
    
    // 3.设置优先级/服务质量
    
    // 3.1设置优先级
    
    /*      iOS 8.0下通过设置服务质量替代
     NSOperationQueuePriorityVeryLow = -8L,
     NSOperationQueuePriorityLow = -4L,
     NSOperationQueuePriorityNormal = 0,
     NSOperationQueuePriorityHigh = 4,
     NSOperationQueuePriorityVeryHigh = 8
     */
    //operation1.queuePriority = NSOperationQueuePriorityVeryHigh;
    
    // 3.2设置服务质量
    /*      iOS 8.0退出
     NSQualityOfServiceUserInteractive = 0x21,
     NSQualityOfServiceUserInitiated = 0x19,
     NSQualityOfServiceUtility = 0x11,
     NSQualityOfServiceBackground = 0x09,
     NSQualityOfServiceDefault = -1
     */

    operation1.qualityOfService = NSQualityOfServiceUserInteractive;
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        
        for (int i = 0; i < 20; i ++) {
            
            NSLog(@"Operation2");
        }
    }];
    
    // 3.将两个操作添加到队列中
    [_queue addOperations:@[operation1,operation2] waitUntilFinished:NO];
}

@end
