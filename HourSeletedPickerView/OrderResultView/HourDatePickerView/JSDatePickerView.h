//
//  JSDatePickerView.h
//  OrderResultView
//
//  Created by ecg on 2017/5/16.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, JSButtonType) {
    JSButtonTypeCalender        = 1110,
    JSButtonTypeConfirm         = 1111
};

@protocol JSDatePickerViewDelegate;
@interface JSDatePickerView : UIView

/*** 代理对象 ***/
@property (nonatomic,weak) id <JSDatePickerViewDelegate> delegate;
@end



@protocol JSDatePickerViewDelegate <NSObject>


/*!
 *  @metohd datePickerView: buttonType:
 *
 *  @param pickVew      自定义视图
 *  @param type         点击按钮的类型,根据不同类型做处理 (1110代表日期按钮  11111代表确认按钮)
 *
 *  @discussion         点击自定义datePicker视图按钮的回调
 */
- (void)datePickerView:(JSDatePickerView *)pickVew buttonType:(JSButtonType)type;

/*!
 *  @metohd datePickerView: selectedIndex:
 *
 *  @param pickView      自定义视图
 *  @param index         选中Row的索引值
 *
 *  @discussion          选择某一行后的索引
 */
- (void)datePickerView:(JSDatePickerView *)pickView selectedIndex:(NSInteger)index;


@end
