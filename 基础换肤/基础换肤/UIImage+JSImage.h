//
//  UIImage+JSImage.h
//  基础换肤
//
//  Created by ShenYj on 16/7/17.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JSImage)

// 根据当前的皮肤设置图片
+ (UIImage *)JSImageNamed:(NSString *)name;

// 保存皮肤
+ (void)saveSkinWithNight:(BOOL)night;

// 获取当前的皮肤情况
+ (BOOL)isNight;

@end
