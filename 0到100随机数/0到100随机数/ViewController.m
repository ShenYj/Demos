//
//  ViewController.m
//  0到100随机数
//
//  Created by ShenYj on 2017/3/24.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *sourceArr = [NSMutableArray arrayWithCapacity:100];
    for (int i = 0; i < 100; i ++) {
        // 得到一个0-99的数组
        [sourceArr addObject:@(i)];
    }
    // 乱序 这里一定要先取出原始数组长度,否则数组长度递减,数据折半
    NSUInteger count = sourceArr.count;
    NSMutableArray *randomArr = [NSMutableArray arrayWithCapacity:100];
    for (int i = 0; i < count; i ++) {
        // 获取一个随机数做角标
        int idx = arc4random() % sourceArr.count;
        // 将随机数索引位置的元素存入到乱序数组中
        //randomArr[i] = sourceArr[idx];
        [randomArr addObject:sourceArr[idx]];
        // 为了更好的乱序效果,将最后一个元素赋值到原始数组中的索引位置,再将最后一个元素删除
        sourceArr[idx] = sourceArr.lastObject;
        // 删除袁术数据最后一个元素
        [sourceArr removeLastObject];
    }
    NSLog(@"%@",randomArr);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
