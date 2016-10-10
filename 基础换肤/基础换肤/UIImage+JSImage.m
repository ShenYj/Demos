//
//  UIImage+JSImage.m
//  基础换肤
//
//  Created by ShenYj on 16/7/17.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "UIImage+JSImage.h"

@implementation UIImage (JSImage)

// 引用全局变量
//extern bool isNight;  标识通过封装的saveSkinWithNight方法传递,不再需要引用外界全局变量,所以设置一个静态全局变量即可
static bool isNight;

// 程序一起动就会执行(只运行一次)
+ (void)load{
    
    isNight = [[NSUserDefaults standardUserDefaults] boolForKey:@"night"];
    
}

+ (UIImage *)JSImageNamed:(NSString *)name{
    
    // 判断当前的皮肤
    if (isNight) { // 夜间
        
        // 夜间图片命名:日间+_night
        name = [NSString stringWithFormat:@"%@_night",name];
        
    }
    
    return [UIImage imageNamed:name];
}

+ (void)saveSkinWithNight:(BOOL)night{
    
    // 赋值
    isNight = night;
    
    // 保存当前选择的皮肤
    [[NSUserDefaults standardUserDefaults]setBool:night forKey:@"night"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isNight{
    
    return isNight;
}

@end
