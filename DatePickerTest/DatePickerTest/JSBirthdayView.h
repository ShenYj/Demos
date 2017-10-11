//
//  JSBirthdayView.h
//  DatePickerTest
//
//  Created by ecg on 2017/10/10.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, BirthdayBtnType) {
    BirthdayBtnTypeConfirm,
    BirthdayBtnTypeCancel,
};

@interface BirthdayBtn : UIButton
@property (nonatomic,assign) BirthdayBtnType btnType;
@end

@protocol JSBirthdayDelegate;
@interface JSBirthdayView : UIView
@property (nonatomic,weak) id <JSBirthdayDelegate> delegate;
- (void)addToView:(UIView *)superView;
@end

@protocol JSBirthdayDelegate <NSObject>

- (void)birthdayView:(JSBirthdayView *)birthdayView selectedDateString:(NSString *)dateString buttonType:(BirthdayBtnType)type;

@end

