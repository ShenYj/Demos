//
//  ViewController.m
//  DatePickerTest
//
//  Created by ecg on 2017/10/10.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import "ViewController.h"
#import "JSBirthdayView.h"

@interface ViewController () <JSBirthdayDelegate>

@property (nonatomic,strong) JSBirthdayView  *customDatePickerView;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    self.datePickerBaseView = [[JSBirthdayView alloc] init];
//    [self.view addSubview: self.datePickerBaseView];
//    [self.datePickerBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.centerY.mas_equalTo(self.view);
//    }];
    self.customDatePickerView = [[JSBirthdayView alloc] init];
    self.customDatePickerView.delegate = self;
//    [self.view addSubview:self.customDatePickerView];
    [self.customDatePickerView addToView:self.view];
    [self.customDatePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.view);
    }];
    
}

- (void)birthdayView:(JSBirthdayView *)birthdayView selectedDateString:(NSString *)dateString buttonType:(BirthdayBtnType)type
{
    NSLog(@" 选择的日期: %@",dateString);
}


@end
