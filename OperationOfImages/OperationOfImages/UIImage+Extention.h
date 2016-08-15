//
//  UIImage+Extention.h
//  OperationOfImages
//
//  Created by ShenYj on 16/8/15.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extention)
/**
 *   根据视图尺寸返回固定Size的Image
 *
 *  @param size Image的尺寸
 *
 *  @return Image
 */
- (UIImage *)js_imageWithSize:(CGSize)size;


#pragma mark -- 设置圆角图片

/**
 *  根据视图尺寸返回固定Size的圆形Image
 *
 *  @param size Image的尺寸
 *
 *  @return 圆形Image
 */
- (UIImage *)js_cornerImageWithSize:(CGSize)size fillClolor:(UIColor *)fillColor;

// 生成圆角图片(优化前)
+ (UIImage *)js_imageWithOriginalImage:(UIImage *)originalImage;



@end
