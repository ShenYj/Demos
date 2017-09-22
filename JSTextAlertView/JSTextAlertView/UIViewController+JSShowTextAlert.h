//
//  UIViewController+JSShowTextAlert.h
//  JSTextAlertView
//
//  Created by ecg on 2017/9/21.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (JSShowTextAlert)

- (void)showComposeViewWithCompeletionHandler:(void (^)(NSString *clsName))compeletionHandler;


@end
