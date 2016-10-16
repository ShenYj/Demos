//
//  NSObject+Runtime.h
//  动态获取对象属性
//
//  Created by ShenYj on 16/8/11.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Runtime)

// 获取类的属性列表数组
+ (NSArray *)js_objProperties;

@end
