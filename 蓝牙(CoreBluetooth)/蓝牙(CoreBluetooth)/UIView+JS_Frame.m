//
//  UIView+JS_Frame.m
//  蓝牙(CoreBluetooth)
//
//  Created by ShenYj on 2017/3/30.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "UIView+JS_Frame.h"

@implementation UIView (JS_Frame)

- (void)setJs_cooridinateX:(CGFloat)js_cooridinateX {
    CGRect frame = self.frame;
    frame.origin.x = js_cooridinateX;
    self.frame = frame;
}

- (CGFloat)js_cooridinateX {
    return self.frame.origin.x;
}

- (void)setJs_cooridinateY:(CGFloat)js_cooridinateY {
    CGRect frame = self.frame;
    frame.origin.y = js_cooridinateY;
    self.frame = frame;
}

- (CGFloat)js_cooridinateY {
    return self.frame.origin.y;
}

- (void)setJs_width:(CGFloat)js_width {
    CGRect frame = self.frame;
    frame.size.width = js_width;
    self.frame = frame;
}

- (CGFloat)js_width {
    return self.frame.size.width;
}

- (void)setJs_height:(CGFloat)js_height {
    CGRect frame = self.frame;
    frame.size.height = js_height;
    self.frame = frame;
}

- (CGFloat)js_height {
    return self.frame.size.height;
}

- (void)setJs_size:(CGSize )js_size {
    CGRect frame = self.frame;
    frame.size = js_size;
    self.frame = frame;
}

- (CGSize )js_size {
    return self.frame.size;
}

- (void)setJs_centerX:(CGFloat)js_centerX {
    CGPoint center = self.center;
    center.x = js_centerX;
    self.center = center;
}

- (CGFloat)js_centerX {
    return self.center.x;
}

- (void)setJs_centerY:(CGFloat)js_centerY {
    CGPoint center = self.center;
    center.y = js_centerY;
    self.center = center;
}

- (CGFloat)js_centerY {
    return self.center.y;
}

@end
