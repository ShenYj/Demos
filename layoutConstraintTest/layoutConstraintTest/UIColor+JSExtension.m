//
//  UIColor+JSExtension.m
//  TableView联动
//
//  Created by ShenYj on 16/8/18.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "UIColor+JSExtension.h"

@implementation UIColor (JSExtension)

+ (UIColor *)js_RGBColorWithRed:(CGFloat)red withGreen:(CGFloat)green withBlue:(CGFloat)blue{
    
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:1.0];
    
}

+ (UIColor *)js_randomColor{
    
    
    CGFloat red = random() % 256;
    CGFloat green = random() % 256;
    CGFloat blue = random() % 256;
    
    return [UIColor js_RGBColorWithRed:red withGreen:green withBlue:blue];
    
}

+ (instancetype)js_colorWithHex:(u_int32_t)hex{
    
    int red = (hex & 0xFF0000) >> 16;
    
    int green = (hex & 0x00FF00) >> 8;
    
    int blue = hex & 0x0000FF;
    
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:1.0];
}

@end
