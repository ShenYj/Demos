//
//  UIColor+JSExtension.h
//  TableView联动
//
//  Created by ShenYj on 16/8/18.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JSExtension)

/**
 *  设置RGB颜色
 *
 *  @param red   red: 0 ~ 255
 *  @param green green: 0 ~ 255
 *  @param blue  blue: 0 ~ 255
 *
 *  @return RGB颜色
 */
+ (UIColor *)js_RGBColorWithRed:(CGFloat)red withGreen:(CGFloat)green withBlue:(CGFloat)blue;

/**
 *  生成随机色
 *
 *  @return 返回随机色
 */
+ (UIColor *)js_randomColor;

/**
 *  根据无符号的 32 位整数转换成对应的 RGB 颜色
 *
 *  @param hex hex
 *
 *  @return UIColor
 */
+ (instancetype)js_colorWithHex:(u_int32_t)hex;


@end
