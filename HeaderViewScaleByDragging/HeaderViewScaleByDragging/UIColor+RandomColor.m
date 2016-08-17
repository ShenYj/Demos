//
//  UIColor+RandomColor.m
//  MajorForum
//
//  Created by ShenYj on 16/7/29.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "UIColor+RandomColor.h"

@implementation UIColor (RandomColor)

+ (UIColor *)js_RGBColorWithRed:(CGFloat)red withGreen:(CGFloat)green withBlue:(CGFloat)blue{
    
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:1.0];
    
}

+ (UIColor *)js_randomColor{
    
    
    CGFloat red = random() % 256;
    CGFloat green = random() % 256;
    CGFloat blue = random() % 256;
    
    return [UIColor js_RGBColorWithRed:red withGreen:green withBlue:blue];
    
}


@end
