//
//  UIViewController+JSShowTextAlert.m
//  JSTextAlertView
//
//  Created by ecg on 2017/9/21.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import <objc/runtime.h>
#import "UIViewController+JSShowTextAlert.h"



@implementation UIViewController (JSShowTextAlert)

- (void)presentContentView:(nullable UIView *)contentView
                  duration:(NSTimeInterval)duration
            springAnimated:(BOOL)isSpringAnimated
                    inView:(nullable UIView *)sView
               displayTime:(NSTimeInterval)displayTime
{
    
    [UIView animateWithDuration:duration animations:^{
        
        [self.view addSubview: contentView];
        
    }];
    
    
//    if (isSpringAnimated) {
//        [UIView animateWithDuration:duration delay:0.f usingSpringWithDamping:0.6 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveLinear animations:^{
//        } completion:^(BOOL finished) {
//        }];
//    } else {
//        [UIView animateWithDuration:duration delay:0.f options:UIViewAnimationOptionCurveLinear animations:^{
//        } completion:^(BOOL finished) {
//        }];
//    }
}
@end
