//
//  JSToolBar.m
//  OrderResultView
//
//  Created by ecg on 2017/5/16.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import "JSToolBar.h"

#import "Masonry.h"
#import "UIColor+JSExtension.h"
#import "JSDateFormatter.h"

CGFloat const kToolBarHeight = 50.f;                    // toolBar高度
static CGFloat const kMargin = 10.f;                    // 间距

@interface JSToolBar  ()
@property (nonatomic,strong) UILabel  *currentDateLabel;
@end

@implementation JSToolBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpToolBar];
    }
    return self;
}

- (void)setUpToolBar
{
    self.backgroundColor = [UIColor js_RGBColorWithRed:95 withGreen:196 withBlue:252];
    
    [self addSubview:self.calenderButton];
    [self addSubview:self.confirmButton];
    [self addSubview:self.currentDateLabel];
    
    [self.calenderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(kMargin);
        make.top.bottom.mas_equalTo(self);
    }];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-kMargin);
        make.top.bottom.mas_equalTo(self);
    }];
    [self.currentDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self);
    }];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kToolBarHeight);
    }];
    // 当前时间
    [JSDateFormatter sharedDateFormatterManager].dateFormat = @"yyyy年MM月dd日";
    NSString *dateString = [[JSDateFormatter sharedDateFormatterManager] stringFromDate:[NSDate date]];
    self.currentDateLabel.text = dateString;
}

#pragma mark
#pragma mark - lazy
- (UIButton *)calenderButton {
    if (!_calenderButton) {
        _calenderButton = [[UIButton alloc] init];
        [_calenderButton setTitle:@"日历" forState:UIControlStateNormal];
        [_calenderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_calenderButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    }
    return _calenderButton;
}
- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] init];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    }
    return _confirmButton;
}
- (UILabel *)currentDateLabel {
    if (!_currentDateLabel) {
        _currentDateLabel = [[UILabel alloc] init];
        _currentDateLabel.textColor = [UIColor whiteColor];
        _currentDateLabel.font = [UIFont systemFontOfSize:24];
        [_currentDateLabel sizeToFit];
    }
    return _currentDateLabel;
}


@end
