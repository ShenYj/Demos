//
//  ViewController.m
//  设置依赖关系
//
//  Created by ShenYj on 16/8/22.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    
    NSOperationQueue *_queue; // 队列
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _queue = [[NSOperationQueue alloc] init]; // 实例化
}

// 模拟软件升级过程： 下载 —> 解压 —> 升级完成
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // 创建操作: 下载,解压,升级
    NSBlockOperation *download = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载(%@)",[NSThread currentThread]);
    }];
    
    NSBlockOperation *decoding = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"解压(%@)",[NSThread currentThread]);
    }];
    
    NSBlockOperation *update = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"升级(%@)",[NSThread currentThread]);
    }];
    
    // 设置依赖关系
    [decoding addDependency:download];  // 解压依赖于下载
    [update addDependency:decoding];    //升级依赖于解压
    
    // 将操作添加到队列中 (同一队列内的操作设置依赖关系)
    // [_queue addOperations:@[download,decoding,update] waitUntilFinished:NO];
    
    // 不同队列之间也可以设置依赖关系
    [_queue addOperations:@[download,update] waitUntilFinished:NO];
    [[NSOperationQueue mainQueue] addOperation:decoding];
    
    
}
@end
