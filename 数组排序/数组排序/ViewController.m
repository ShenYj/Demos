//
//  ViewController.m
//  数组排序
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
    
}

/** 可变数组排序 */
- (void)test2 {
    NSArray *arr = @[@61,@5,@10,@2,@20,@41,@4,@65,@23,@9];
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:arr];
    [mArr sortUsingComparator:^NSComparisonResult(NSNumber *_Nonnull obj1, NSNumber *_Nonnull obj2) {
        
        // 简写
        return obj1.integerValue > obj2.integerValue;
        
        // NSOrderedDescending -> 交换两个元素的位置
        // NSOrderedAscending  -> 保持两个元素位置不变
        if (obj1.integerValue > obj2.integerValue) {
            return NSOrderedDescending;
        } else if (obj1.integerValue < obj2.integerValue) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
    NSLog(@"%@",mArr);
}

/** 不可变数组排序 */
- (void)test1 {
    NSArray *arr = @[@61,@5,@10,@2,@20,@41,@4,@65,@23,@9];
    NSArray *sortedArr = [arr sortedArrayUsingComparator:^NSComparisonResult(NSNumber *_Nonnull obj1,NSNumber * _Nonnull obj2) {
        if (obj1.integerValue > obj2.integerValue) {
            return NSOrderedDescending;
        } else if (obj1.integerValue < obj2.integerValue) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
    NSLog(@"%@",sortedArr);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
