//
//  UIImage+JSExtension.h
//  HeaderViewScaleByDragging
//
//  Created by ShenYj on 16/8/17.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)


/**
 *  高性能绘制圆角图片
 *
 *  @param size       图片尺寸
 *  @param fillColor  圆角图片外围填充色
 *  @param completion 完成回调,返回圆角图片
 */
- (void)js_cornerImageWithSize:(CGSize)size fillClolor:(UIColor *)fillColor completion:(void(^)(UIImage *img))completion;

/**
 *  高性能绘制固定尺寸图片
 *
 *  @param size       所生成的图片尺寸
 *  @param completion 完成回调,返回固定尺寸图片
 */
- (void)js_ImageWithSize:(CGSize)size completion:(void(^)(UIImage *img))completion;



/**
 *  创建纯色图片
 *
 *  @param color     生成纯色图片的颜色
 *  @param imageSize 需要创建纯色图片的尺寸
 *
 *  @return 纯色图片
 */
+ (UIImage *)js_createImageWithColor:(UIColor *)color withSize:(CGSize)imageSize;

/**
 *  创建圆角图片
 *
 *  @param originalImage 原始图片
 *
 *  @return 带圆角的图片
 */
+ (UIImage *)js_imageWithOriginalImage:(UIImage *)originalImage;

/**
 *  创建圆角纯色图片
 *
 *  @param color     设置圆角纯色图片的颜色
 *  @param imageSize 设置元角纯色图片的尺寸
 *
 *  @return 圆角纯色图片
 */
+ (UIImage *)js_createRoundedImageWithColor:(UIColor *)color withSize:(CGSize)imageSize;

/**
 *  生成带圆环的圆角图片
 *
 *  @param originalImage 原始图片
 *  @param borderColor   圆环颜色
 *  @param borderWidth   圆环宽度
 *
 *  @return 带圆环的圆角图片
 */
+ (UIImage *)js_imageWithOriginalImage:(UIImage *)originalImage withBorderColor:(UIColor *)borderColor withBorderWidth:(CGFloat)borderWidth;




@end
