//
//  UIButton+JSButtonExtension.m
//  BaseViewController
//
//  Created by ShenYj on 2016/11/18.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "UIButton+JSButtonExtension.h"

@implementation UIButton (JSButtonExtension)

- (instancetype)initWithTitle:(NSString *)title withFont:(CGFloat)font withTarget:(id)target withAction:(SEL)action {
    return [self initWithTitle:title withFont:font withNormalColor:nil withHighlightedColor:nil withTarget:target withAction:action];
}

- (instancetype)initWithTitle:(NSString *)title withFont:(CGFloat)font withNormalColor:(UIColor *)normalColor withHighlightedColor:(UIColor *)highlightedColor withTarget:(id)target withAction:(SEL)action {
    
    self = [super init];
    if (self) {
        
        self.titleLabel.font = [UIFont systemFontOfSize:font];
        if (title) {
            [self setTitle:title forState:UIControlStateNormal];
            [self setTitle:title forState:UIControlStateHighlighted];
        }
        if ( target && action ) {
            [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        }
        [self sizeToFit];
        
        normalColor ? ([self setTitleColor:normalColor forState:UIControlStateNormal]): ([self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal]);
        highlightedColor ? ([self setTitleColor:highlightedColor forState:UIControlStateHighlighted]) : ([self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted]);
        
    }
    return self;
}


@end
