//
//  UIImage+Extention.m
//  OperationOfImages
//
//  Created by ShenYj on 16/8/15.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "UIImage+Extention.h"

@implementation UIImage (Extention)

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

@end
