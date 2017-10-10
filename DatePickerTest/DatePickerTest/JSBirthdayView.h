//
//  JSBirthdayView.h
//  DatePickerTest
//
//  Created by ecg on 2017/10/10.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol JSBirthdayDelegate;
@interface JSBirthdayView : UIView
@property (nonatomic,weak) id <JSBirthdayDelegate> delegate;
@end

@protocol JSBirthdayDelegate <NSObject>

- (void)birthdayView:(JSBirthdayView *)birthdayView selectedDateString:(NSString *)dateString;

@end

