//
//  JSBirthdayView.m
//  DatePickerTest
//
//  Created by ecg on 2017/10/10.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import "JSBirthdayView.h"

@interface JSDatePicker : UIDatePicker
@end
@implementation JSDatePicker

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self clearSeparatorWithView:self];
}
- (void)clearSeparatorWithView:(UIView * )view
{
    if(view.subviews != 0){
        if(view.bounds.size.height < 5){
            view.backgroundColor = [UIColor clearColor];
        }
        [view.subviews enumerateObjectsUsingBlock:^( UIView *  obj, NSUInteger idx, BOOL *  stop) {
            [self clearSeparatorWithView:obj];
        }];
    }
}


@end


static CGFloat const kHorizontalMargin = 30.0f;
static CGFloat const kVerticalMargin = 20.0f;
static CGFloat const kButtonHeight = 44.0f;
static CGFloat const kBirthdayHeight = 260.0f;

@interface JSBirthdayView ()

@property (nonatomic,strong) JSDatePicker    *datePicker;
@property (nonatomic,strong) NSDateFormatter *dateFormatter;
@property (nonatomic,  copy) NSString        *dateString;

@property (nonatomic,strong) UILabel         *horizontalSeperator;
@property (nonatomic,strong) UILabel         *verticalSeperator;
@property (nonatomic,strong) UIButton        *confirmBtn;
@property (nonatomic,strong) UIButton        *cancelBtn;

@property (nonatomic,strong) UIView          *seperatorContainerView;
@property (nonatomic,strong) NSMutableArray  *seperators_top;
@property (nonatomic,strong) NSMutableArray  *seperators_bottom;

@end

@implementation JSBirthdayView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 1;
    
    [self addSubview: self.datePicker];
    [self addSubview: self.horizontalSeperator];
    [self addSubview: self.verticalSeperator];
    [self addSubview: self.cancelBtn];
    [self addSubview: self.confirmBtn];
    [self addSubview: self.seperatorContainerView];
    
    CGFloat datePickerHeight = kBirthdayHeight - kVerticalMargin - kButtonHeight;
    CGFloat birdayViewWidth = ScreenW - 2 * kHorizontalMargin;
    
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(kVerticalMargin);
        make.height.mas_equalTo(datePickerHeight);
        make.left.mas_equalTo(self).mas_offset(kHorizontalMargin*0.5);
        make.right.mas_equalTo(self).mas_offset(-kHorizontalMargin*0.5);
    }];
    CGFloat onePexel = 1 / [UIScreen mainScreen].scale;
    [self.horizontalSeperator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.datePicker.mas_bottom);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(onePexel);
    }];
    [self.verticalSeperator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.horizontalSeperator.mas_bottom);
        make.width.mas_equalTo(onePexel);
        make.bottom.centerX.mas_equalTo(self);
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.horizontalSeperator.mas_bottom);
        make.bottom.left.mas_equalTo(self);
        make.right.mas_equalTo(self.verticalSeperator.mas_left);
    }];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.horizontalSeperator.mas_bottom);
        make.bottom.right.mas_equalTo(self);
        make.left.mas_equalTo(self.verticalSeperator.mas_right);
    }];
    [self.seperatorContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.datePicker);
        make.centerY.mas_equalTo(self.datePicker);
        make.height.mas_equalTo(45);
    }];
    
    [self.seperators_top mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:30 tailSpacing:30];
    [self.seperators_top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(3);
        make.top.mas_equalTo(self.seperatorContainerView);
    }];
    [self.seperators_bottom mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:30 tailSpacing:30];
    [self.seperators_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(3);
        make.bottom.mas_equalTo(self.seperatorContainerView);
    }];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(birdayViewWidth, kBirthdayHeight)).priorityHigh();
    }];
    
    self.dateString = [self.dateFormatter stringFromDate:self.datePicker.date];
}

#pragma mark - target

- (void)datePickerValueChanged:(UIDatePicker *)datePicker
{
    self.dateString = [self.dateFormatter stringFromDate:self.datePicker.date];
}

- (void)confirmBtnClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(birthdayView:selectedDateString:)]) {
        [self.delegate birthdayView:self selectedDateString:self.dateString];
    }
    NSLog(@"选中日期: %@",self.dateString);
    [self removeFromSuperview];
}

- (void)cancelBtnClick:(UIButton *)button
{
    [self removeFromSuperview];
}

#pragma mark - lazy

- (JSDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[JSDatePicker alloc] initWithFrame:CGRectZero];
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//[NSLocale currentLocale];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.timeZone = [NSTimeZone localTimeZone];
        _datePicker.layer.cornerRadius = 3;
        _datePicker.layer.masksToBounds = YES;
        [_datePicker addTarget: self
                        action: @selector(datePickerValueChanged:)
              forControlEvents: UIControlEventValueChanged];
    }
    return _datePicker;
}
- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return _dateFormatter;
}
- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc] init];
        _confirmBtn.backgroundColor = [UIColor whiteColor];
        [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_confirmBtn addTarget: self
                        action: @selector(confirmBtnClick:)
              forControlEvents: UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] init];
        _cancelBtn.backgroundColor = [UIColor whiteColor];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget: self
                       action: @selector(cancelBtnClick:)
             forControlEvents: UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
- (UILabel *)horizontalSeperator {
    if (!_horizontalSeperator) {
        _horizontalSeperator = [[UILabel alloc] init];
        _horizontalSeperator.backgroundColor = [UIColor grayColor];
    }
    return _horizontalSeperator;
}
- (UILabel *)verticalSeperator {
    if (!_verticalSeperator) {
        _verticalSeperator = [[UILabel alloc] init];
        _verticalSeperator.backgroundColor = [UIColor grayColor];
    }
    return _verticalSeperator;
}
- (UIView *)seperatorContainerView {
    if (!_seperatorContainerView) {
        _seperatorContainerView = [[UIView alloc] init];
        _seperatorContainerView.backgroundColor = [UIColor clearColor];
    }
    return _seperatorContainerView;
}
- (NSMutableArray *)seperators_top {
    if (!_seperators_top) {
        NSMutableArray <UIView *> *tempArr = [NSMutableArray arrayWithCapacity:3];
        for (int i = 0; i < 3; i ++) {
            @autoreleasepool{
                UIView *seperator = [[UIView alloc] init];
                seperator.backgroundColor = [UIColor blueColor];
                [tempArr addObject:seperator];
                [self.seperatorContainerView addSubview:seperator];
            }
        }
        _seperators_top = tempArr.copy;
    }
    return _seperators_top;
}
- (NSMutableArray *)seperators_bottom {
    if (!_seperators_bottom) {
        NSMutableArray <UIView *> *tempArr = [NSMutableArray arrayWithCapacity:3];
        for (int i = 0; i < 3; i ++) {
            @autoreleasepool{
                UIView *seperator = [[UIView alloc] init];
                seperator.backgroundColor = [UIColor blueColor];
                [tempArr addObject:seperator];
                [self.seperatorContainerView addSubview:seperator];
            }
        }
        _seperators_bottom = tempArr.copy;
    }
    return _seperators_bottom;
}


@end
