
//
//  JSDatePickerView.m
//  OrderResultView
//
//  Created by ecg on 2017/5/16.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import "JSDatePickerView.h"
#import "JSToolBar.h"


#import "UIColor+JSExtension.h"
#import "Masonry.h"
#import "JSDateFormatter.h"
#import "NSObject+JSObjc.h"

static CGFloat const kDatePickerViewHeight = 300.f;         // 自身高度
static CGFloat const kDatePickerViewCellHeight = 55.f;      // 每一行的高度
extern CGFloat const kToolBarHeight;
static int const kHoursCount = 24;

@interface JSDatePickerView () <UIPickerViewDataSource,UIPickerViewDelegate>

/*** 自定义ToolBar ***/
@property (nonatomic,strong) JSToolBar     *toolBar;
/*** 自定义日期选择器 ***/
@property (nonatomic,strong) UIPickerView  *pickerView;
/*** 数据源 ***/
@property (nonatomic,strong) NSArray       *hours;
/*** 选中索引 ***/
@property (nonatomic,assign) NSInteger     selectedRow;
/*** 中心的"时"Label ***/
@property (nonatomic,strong) UILabel       *centerIndicatorLabel;

@end

@implementation JSDatePickerView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpDatePickeView];
    }
    return self;
}

- (void)setUpDatePickeView
{
    self.backgroundColor = [UIColor whiteColor];
    // 添加子控件
    [self addSubview: self.toolBar];
    [self addSubview: self.pickerView];
    [self addSubview: self.centerIndicatorLabel];
    // 添加约束
    [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
    }];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.toolBar.mas_bottom);
        make.left.bottom.right.mas_equalTo(self);
    }];
    [self.centerIndicatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.pickerView);
        make.left.mas_equalTo(self).mas_offset([UIScreen mainScreen].bounds.size.width * 0.7);
    }];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        make.height.mas_equalTo(kDatePickerViewHeight);
    }];
    
    // 添加事件
    [self.toolBar.calenderButton addTarget:self action:@selector(clickCalenderButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolBar.confirmButton addTarget:self action:@selector(clickConfirmButton:) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark
#pragma mark - target

- (void)clickCalenderButton:(UIButton *)calenderButton
{
    if ([self.delegate respondsToSelector:@selector(datePickerView:buttonType:)]) {
        [self.delegate datePickerView:self buttonType:JSButtonTypeCalender];
    }
}
- (void)clickConfirmButton:(UIButton *)confirmButton
{
    if ([self.delegate respondsToSelector:@selector(datePickerView:buttonType:)]) {
        [self.delegate datePickerView:self buttonType:JSButtonTypeConfirm];
    }
}

#pragma mark
#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.hours.count;
}

#pragma mark
#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return kDatePickerViewCellHeight;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    UILabel *hourLabel = [[UILabel alloc] init];
    // 数据
    NSString *hourString = self.hours[row];

    if ( row == self.selectedRow) {
        hourLabel.textColor = [UIColor js_RGBColorWithRed:95 withGreen:196 withBlue:252];
    } else {
        hourLabel.textColor = [UIColor grayColor];
    }
    hourLabel.text = hourString;
    hourLabel.textAlignment = NSTextAlignmentCenter;
    hourLabel.font = [UIFont systemFontOfSize:30];
    return hourLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedRow = row;
    if ([self.delegate respondsToSelector:@selector(datePickerView:selectedIndex:)]) {
        [self.delegate datePickerView:self selectedIndex:row];
    }
    [pickerView reloadComponent:component];
}

#pragma mark
#pragma mark - lazy

- (JSToolBar *)toolBar {
    if (!_toolBar) {
        _toolBar = [[JSToolBar alloc] init];
    }
    return _toolBar;
}
- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
    }
    return _pickerView;
}
- (NSArray *)hours {
    if (!_hours) {
        NSMutableArray *tempArr = [NSMutableArray array];
        for (int i = 0; i < kHoursCount; i ++) {
            [tempArr addObject:[NSString stringWithFormat:@"%02d : 00",i]];
        }
        _hours = tempArr.copy;
    }
    return _hours;
}
- (UILabel *)centerIndicatorLabel {
    if (!_centerIndicatorLabel) {
        _centerIndicatorLabel = [[UILabel alloc] init];
        _centerIndicatorLabel.textColor = [UIColor grayColor];
        _centerIndicatorLabel.textAlignment = NSTextAlignmentCenter;
        _centerIndicatorLabel.text = @"时";
        _centerIndicatorLabel.font = [UIFont systemFontOfSize:24];
    }
    return _centerIndicatorLabel;
}

@end
