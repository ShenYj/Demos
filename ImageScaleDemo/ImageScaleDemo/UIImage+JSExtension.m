//
//  UIImage+JSExtension.m
//  HeaderViewScaleByDragging
//
//  Created by ShenYj on 16/8/17.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "UIImage+JSExtension.h"

@implementation UIImage (Color)

// 根据传入Size重新生成图片(优化后)
- (void)js_ImageWithSize:(CGSize)size completion:(void(^)(UIImage *img))completion{
    
    // 异步处理
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 开启图形上下文
        UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
        
        // 设置rect
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        // 将原始图片绘制到图形上下文中
        [self drawInRect:rect];
        
        // 从图形上下获取图片
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        
        // 关闭图形上下文
        UIGraphicsEndImageContext();
        
        // 主线程返回圆形图片
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (completion) {
                completion(image);
            }
        });
        
    });
    
}

// 生成圆角图片(优化后)
- (void)js_cornerImageWithSize:(CGSize)size fillClolor:(UIColor *)fillColor completion:(void(^)(UIImage *img))completion{
    
    // 异步处理
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
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
        
        // 主线程返回圆形图片
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (completion) {
                completion(image);
            }
        });
        
    });
    
}


// 生成纯色图片
+ (UIImage *)js_createImageWithColor:(UIColor *)color withSize:(CGSize)imageSize{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, imageSize.width, imageSize.height);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGContextFillRect(context, rect);
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
}

// 生成圆角图片
+ (UIImage *)js_imageWithOriginalImage:(UIImage *)originalImage{
    
    CGRect rect = CGRectMake(0, 0, originalImage.size.width, originalImage.size.height);
    
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, 0.0);
    
    CGFloat cornerRadius = MIN(originalImage.size.width, originalImage.size.height) * 0.5;
    
    [[UIBezierPath bezierPathWithRoundedRect:rect
                                cornerRadius:cornerRadius] addClip];
    
    [originalImage drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

// 生成纯色圆角图片
+ (UIImage *)js_createRoundedImageWithColor:(UIColor *)color withSize:(CGSize)imageSize{
    
    UIImage *originalImage = [self js_createImageWithColor:color withSize:imageSize];
    
    return [self js_imageWithOriginalImage:originalImage];
}

// 生成带圆环的圆角图片
+ (UIImage *)js_imageWithOriginalImage:(UIImage *)originalImage withBorderColor:(UIColor *)borderColor withBorderWidth:(CGFloat)borderWidth{
    
    CGRect rect = CGRectMake(0, 0, originalImage.size.width, originalImage.size.height);
    
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, 0.0);
    
    CGFloat cornerRadius = MIN(originalImage.size.width, originalImage.size.height) * 0.5;
    
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius] addClip];
    
    [originalImage drawInRect:rect];
    
    CGPoint center = CGPointMake(originalImage.size.width * 0.5, originalImage.size.height * 0.5);
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:center radius:cornerRadius - borderWidth*0.5 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    circlePath.lineWidth = borderWidth;
    
    [borderColor setStroke];
    
    [circlePath stroke];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
    
}



@end
