//
//  ViewController.m
//  动态获取对象属性
//
//  Created by ShenYj on 16/8/11.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NSObject+Runtime.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
         Runtime 消息机制: 程序启动时,首先加载运行时,是OC的底层, 将OC代码转换成C代码
     应用场景:
     
     1. 关联对象            ->  (给分类动态添加属性时简单提到过一次)
     2. 交换方法            ->  (换肤时介绍过)
     3. 动态获取对象属性

     */
    
    NSArray *properties = [Person js_objProperties];
    
    NSLog(@"%@",properties);
    
}


@end
