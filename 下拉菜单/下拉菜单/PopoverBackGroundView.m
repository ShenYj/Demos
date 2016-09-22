//
//  PopoverBackGroundView.m
//  下拉菜单
//
//  Created by ShenYj on 16/9/22.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//


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

@end
