//
//  JSTextAlertView.h
//  JSTextAlertView
//
//  Created by ecg on 2017/9/21.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSTextAlertButton : UIButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType NS_UNAVAILABLE;
+ (instancetype)buttonWithTitle:(nullable NSString *)title handler:(void (^ __nullable)(JSTextAlertButton *button ))handler;

/*** 线条颜色 ***/
@property (nonatomic, strong) UIColor *lineColor;
/*** 线宽 ***/
@property (nonatomic, assign) CGFloat lineWidth;
/*** 边缘留白 top -> 间距 / bottom -> 最底部留白(根据不同情况调整不同间距) ***/
@property (nonatomic, assign) UIEdgeInsets edgeInsets;
/*** 按钮回调 ***/
@property (nonatomic, copy) void (^buttonClickedBlock)(JSTextAlertButton *alertButton);

@end

@interface JSTextAlertView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;


- (void)showComposeViewWithCompeletionHandler:(void (^)(NSString *clsName))compeletionHandler;
- (void)hiddenCurrentView;


- (instancetype)initWithTitle: (nullable NSString *)title
                      message: (nullable NSString *)message
                constantWidth: (CGFloat)constantWidth;

/// 子视图按钮(zhOverflyButton)的高度，默认49
@property (nonatomic, assign) CGFloat subOverflyButtonHeight;

/// 纵向依次向下添加
- (void)addAction:(JSTextAlertButton *)action;

/// 水平方向两个button
- (void)adjoinWithLeftAction:(JSTextAlertButton *)leftAction rightAction:(JSTextAlertButton *)rightAction;

@end

NS_ASSUME_NONNULL_END
