//
//  NSObject+JSObjc.h
//  Demos
//
//  Created by ShenYj on 16/9/3.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JSObjc)

/**
 *  获取类的所有属性
 *
 *  @return 存放属性的数组
 */
+ (NSArray *)js_objProperties;


/**
 *  打印类的所有属性
 *
 *  @param className 类名
 */
+ (void)js_logPrivatePropertiesWithClass:(NSString *)className;

/**
 *  打印类的所有成员变量
 *
 *  @param className 类名
 */
+ (void)js_logPrivateIvarsWithClass:(NSString *)className;


@end
