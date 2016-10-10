//
//  UIImage+JSSkin.m
//  运行时换肤
//
//  Created by ShenYj on 16/7/17.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "UIImage+JSSkin.h"
#import <objc/runtime.h>

@implementation UIImage (JSSkin)

// 夜间模式标识(静态全局变量)
static bool isNight;
// 色表的缓存
static NSDictionary *colorCache;

+ (void)load{

    // 获取偏好设置中的皮肤模式
    isNight = [[NSUserDefaults standardUserDefaults] boolForKey:@"isNight"];
    
    // 使用运行时机制交换方法 一旦交换,在App整个生命周期都会交换
    // 1. 获取对应交换的方法
    Method method1 = class_getClassMethod([UIImage class], @selector(imageNamed:));
    Method method2 = class_getClassMethod([UIImage class], @selector(jsImageNamed:));
    // 2. 交换方法
    method_exchangeImplementations(method1, method2);
    
    // 加载色表缓存
    [self loadColorCache];
}

+ (UIColor *)loadColorWithKey:(NSString *)key{

    // 每个皮肤除了设置不同图片外,通常还需要有一套对应的配色方案,一般使用plist色表来保存方案,色表的命名规范: 控制器_视图_属性
    
    // 从内存中刚取出对应的颜色
    return colorCache[key];
}

// 加载色表缓存  硬盘数据-->内存数据
+ (void)loadColorCache{
    
    // 从plist中取出色表
    NSString *path = @"";
    if (isNight) {
        path = @"skin/night/color.plist";
    }else {
        path = @"skin/default/color.plist";
    }
    
    NSDictionary *colorDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:nil]];
    
    // 创建可变字典  将字符串字典转换成UIColor字典
    NSMutableDictionary *tempDict = [NSMutableDictionary dictionary];
    
    // 遍历字符串字典
    [colorDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        // 根据传入的key取出value
        // 将得到的value(NSString*)分隔转成一个数组
        NSArray *colorArr = [obj componentsSeparatedByString:@","];
        
        CGFloat red = [colorArr[0] floatValue];
        CGFloat green = [colorArr[1] floatValue];
        CGFloat blue = [colorArr[2] floatValue];
        
        // 设置色表的内存缓存 方便从内存中取出对应的颜色,避免每一次都从沙盒中取出色表(影响性能)
        // 内存缓存 选型  字典(key:plist中的key  value:色值NSString) -> 字典(key:不变  value:UIColor)
        UIColor *color = [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:1.0];
        
        // 存到临时可变字典中
        [tempDict setObject:color forKey:key];
        
    }];
    
    // 存到缓存
    colorCache = tempDict.copy;

    
}

// 自定义方法,根据当前皮肤设置图片
+ (UIImage *)jsImageNamed:(NSString *)name{
    
    if (isNight) { // 夜间模式
        
        name = [NSString stringWithFormat:@"%@_night",name];
    }
    
    return [UIImage jsImageNamed:name];
}

+ (void)saveSkinModeWithNight:(BOOL)night{
    
    // 赋值,记录当前皮肤状态
    isNight = night;
    
    // 本地记录状态(偏好设置)
    [[NSUserDefaults standardUserDefaults] setBool:isNight forKey:@"isNight"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 加载色表缓存
    [self loadColorCache];
}

+ (BOOL)isNight{
    
    // 返回当前皮肤状态
    return isNight;
}

@end
