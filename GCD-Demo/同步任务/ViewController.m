//
//  ViewController.m
//  同步任务
//
//  Created by ShenYj on 16/8/21.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

// 任务的依赖关系

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"touchesBegan:%@",[NSThread currentThread]);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        NSLog(@"%@",[NSThread currentThread]);
        
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:5];
            NSLog(@"操作1:-->(%@)",[NSThread currentThread]);
        });
        
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"操作2:(%@)",[NSThread currentThread]);
        });
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"操作3:(%@)",[NSThread currentThread]);
        });
    });
}

@end
