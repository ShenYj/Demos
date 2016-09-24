//
//  PopoverBackGroundView.m
//  下拉菜单
//
//  Created by ShenYj on 16/9/22.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

// http://www.cocoachina.com/ios/20130513/6185.html

#import "PopoverBackGroundView.h"

static CGFloat const kArrowBase = 30.0f;
static CGFloat const kArrowHeight = 0.0f;
static CGFloat const kBorderInset = 0.0f;

@implementation PopoverBackGroundView

@synthesize arrowDirection  = _arrowDirection;
@synthesize arrowOffset     = _arrowOffset;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

//arrowBase方法确定arrow底部的宽度，arrowHeight方法确定arrow的高度
+ (CGFloat)arrowBase{
    
    return kArrowBase;
}

+ (CGFloat)arrowHeight{
    
    return kArrowHeight;
}

+ (UIEdgeInsets)contentViewInsets{
    
    return UIEdgeInsetsMake(kBorderInset, kBorderInset, kBorderInset, kBorderInset);
}

//每次popover的background view的子类的bounds 改变时，这个arrow的frame需要重新计算。我们可以通过覆盖layoutSubviews来达到目的
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize arrowSize = CGSizeMake([[self class] arrowBase], [[self class] arrowHeight]);
    self.arrowImageView.image = [self drawArrowImage:arrowSize];
    self.arrowImageView.frame = CGRectMake(((self.bounds.size.width - arrowSize.width) * kBorderInset), 0.0f, arrowSize.width, arrowSize.height);
}


- (UIImage *)drawArrowImage:(CGSize)size {
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor clearColor] setFill];
    CGContextFillRect(ctx, CGRectMake(0.0f, 0.0f, size.width, size.height));
    CGMutablePathRef arrowPath = CGPathCreateMutable();
    CGPathMoveToPoint(arrowPath, NULL, (size.width/2.0f), 0.0f);
    CGPathAddLineToPoint(arrowPath, NULL, size.width, size.height);
    CGPathAddLineToPoint(arrowPath, NULL, 0.0f, size.height);
    CGPathCloseSubpath(arrowPath);
    CGContextAddPath(ctx, arrowPath);
    CGPathRelease(arrowPath);
    UIColor *fillColor = [UIColor yellowColor];
    CGContextSetFillColorWithColor(ctx, fillColor.CGColor);
    CGContextDrawPath(ctx, kCGPathFill);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
