//
//  JSDatePicker.h
//  DatePickerTest
//
//  Created by ecg on 2017/10/11.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JSDatePickerDelegate;
@interface JSDatePicker : UIControl

@property (nonatomic,  weak) id <JSDatePickerDelegate> delegate;
@property (nonatomic,strong) NSDate *date;

- (instancetype)initWithFrame:(CGRect)frame maxDate:(NSDate *)maxDate minDate:(NSDate *)minDate showValidDatesOnly:(BOOL)showValidDatesOnly;

@end


@protocol JSDatePickerDelegate <NSObject>

@optional
- (void)dateChanged:(JSDatePicker *)sender;

@end
