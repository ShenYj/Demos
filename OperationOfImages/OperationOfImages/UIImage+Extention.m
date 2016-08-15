//
//  UIImage+Extention.m
//  OperationOfImages
//
//  Created by ShenYj on 16/8/15.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "UIImage+Extention.h"

@implementation UIImage (Extention)

// 根据视图尺寸返回固定Size的Image
- (UIImage *)js_imageWithSize:(CGSize)size{
    
    // 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
    
    // 设置rect
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    // 将图片绘制到图形上下文
    [self drawInRect:rect];
    
    // 从图形上下问获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    // 返回图片
    return image;
    
}

// 生成圆角图片(优化后)
- (UIImage *)js_cornerImageWithSize:(CGSize)size fillClolor:(UIColor *)fillColor{
    
    
    
    // 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
    
    // 设置rect
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    // 设置填充色
    [fillColor set];
    UIRectFill(rect);
    
    // 计算半径
    CGFloat cornerRadius = MIN(size.width, size.height) * 0.5;
    
    // 设置圆形路径并切割
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius] addClip];
    
    // 将原始图片绘制到图形上下文中
    [self drawInRect:rect];
    
    // 从图形上下获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    // 返回圆形图片
    return image;
}



// 生成圆角图片(优化前)
+ (UIImage *)js_imageWithOriginalImage:(UIImage *)originalImage{
    
    CGRect rect = CGRectMake(0, 0, originalImage.size.width, originalImage.size.height);
    
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, 0.0);
    
    CGFloat cornerRadius = MIN(originalImage.size.width, originalImage.size.height) * 0.5;
    
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius] addClip];
    
    [originalImage drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}


@end
