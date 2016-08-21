//
//  ViewController.m
//  一次性执行
//
//  Created by ShenYj on 16/8/21.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 一次性执行  (线程安全,只执行一次)
    for (int i = 0; i < 10; i ++) {

        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            NSLog(@"%s",__func__);
        });
        
    }

}

@end
