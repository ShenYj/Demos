//
//  JSDatePicker.m
//  DatePickerTest
//
//  Created by ecg on 2017/10/11.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import "JSDatePicker.h"

@interface JSDatePicker () <UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSInteger nDays;
}
@property (nonatomic,strong) UIPickerView    *picker;
@property (nonatomic,strong) NSCalendar      *calendar;
@property (nonatomic,strong) NSDate          *minDate;
@property (nonatomic,strong) NSDate          *maxDate;
@property (readonly, strong) NSDate          *earliestPresentedDate;
@property (nonatomic,assign) BOOL            showOnlyValidDates;
@property (nonatomic,strong) NSDateFormatter *dateFormatter;

@property (nonatomic,strong) NSMutableArray  *dateArray;

@end

@implementation JSDatePicker

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    self.minDate = [NSDate dateWithTimeIntervalSince1970:0];
    [self commonInit];
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame maxDate:(NSDate *)maxDate minDate:(NSDate *)minDate showValidDatesOnly:(BOOL)showValidDatesOnly
{
    self = [super initWithFrame:frame];
    
    if (!self) {
        return nil;
    }
    assert((((minDate) && (maxDate)) && ([minDate compare:maxDate] != NSOrderedDescending)));
    
    self.minDate = minDate;
    self.maxDate = maxDate;
    self.showOnlyValidDates = showValidDatesOnly;
    
    [self commonInit];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (!self) {
        return nil;
    }
    [self commonInit];
    return self;
}

- (NSDate *)earliestPresentedDate
{
    return self.showOnlyValidDates ? self.minDate : [NSDate dateWithTimeIntervalSince1970:0];
}

- (void)commonInit
{
    self.backgroundColor = [UIColor orangeColor];
    self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    self.picker = [[UIPickerView alloc] initWithFrame:self.bounds];
    self.picker.dataSource = self;
    self.picker.delegate = self;
    
    [self initDate];
    [self showDateOnPicker:self.date];
    [self addSubview:self.picker];
    
    [self.picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

- (void)showDateOnPicker:(NSDate *)date
{
    self.date = date;
    NSDateComponents *components = [self.calendar components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                                                    fromDate: self.earliestPresentedDate];
    NSDate *fromDate = [self.calendar dateFromComponents:components];
    components = [self.calendar components: (NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute)
                                  fromDate: fromDate
                                    toDate: date
                                   options: 0];
    
    NSInteger hour = [components hour] + 24 * (INT16_MAX / 120);
    NSInteger minute = [components minute] + 60 * (INT16_MAX / 120);
    NSInteger day = [components day];
    [self.picker selectRow:day inComponent:0 animated:YES];
    [self.picker selectRow:hour inComponent:1 animated:YES];
    [self.picker selectRow:minute inComponent:2 animated:YES];
}

- (void)initDate
{
    NSInteger startDayIndex = 0;
    NSInteger startHourIndex = 0;
    NSInteger startMinuteIndex = 0;
    
    if ((self.minDate) && (self.maxDate) && self.showOnlyValidDates) {
        NSDateComponents *components = [self.calendar components: NSCalendarUnitDay
                                                        fromDate: self.minDate
                                                          toDate: self.maxDate
                                                         options: 0];
        nDays = components.day + 1;
    } else {
        nDays = INT16_MAX;
    }
    NSDate *dateToPresent;
    
    if ([self.minDate compare:[NSDate date]] == NSOrderedDescending) {
        dateToPresent = self.minDate;
    } else if ([self.maxDate compare:[NSDate date]] == NSOrderedAscending) {
        dateToPresent = self.maxDate;
    } else {
        dateToPresent = [NSDate date];
    }
    
    NSDateComponents *todaysComponents = [self.calendar components: NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute
                                                          fromDate: self.earliestPresentedDate
                                                            toDate: dateToPresent
                                                           options: 0];
    
    startDayIndex = todaysComponents.day;
    startHourIndex = todaysComponents.hour;
    startMinuteIndex = todaysComponents.minute;
    
    self.date = [NSDate dateWithTimeInterval:startDayIndex*24*60*60+startHourIndex*60*60+startMinuteIndex*60 sinceDate:self.earliestPresentedDate];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return nDays;
    } else if (component == 1) {
        return INT16_MAX;
    } else {
        return INT16_MAX;
    }
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return 170;
            break;
        case 1:
            return 60;
            break;
        case 2:
            return 60;
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 35;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *lblDate = [[UILabel alloc] init];
    lblDate.font = [UIFont systemFontOfSize:25.0];
    lblDate.textColor = [UIColor whiteColor];
    lblDate.backgroundColor = [UIColor clearColor];
    lblDate.textAlignment = NSTextAlignmentCenter;
    
    if (component == 0) // Date
    {
        NSDate *aDate = [NSDate dateWithTimeInterval:row*24*60*60 sinceDate:self.earliestPresentedDate];
        NSDateComponents *components = [self.calendar components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:aDate];
        NSDate *date = [self.calendar dateFromComponents:components];
        
//        NSDate *aDate = [NSDate dateWithTimeInterval: row * 24 * 60 * 60 sinceDate: self.earliestPresentedDate];
//        NSDateComponents *components = [self.calendar components: NSCalendarUnitEra | NSCalendarUnitYear fromDate: [NSDate date]];
//        NSDate *currentDate = [self.calendar dateFromComponents:components];
//        components = [self.calendar components: NSCalendarUnitEra | NSCalendarUnitYear fromDate: aDate];
//        NSDate *otherDate = [self.calendar dateFromComponents:components];
        self.dateFormatter.dateFormat = @"yyyy";
//        if ([date isEqualToDate:otherDate]) {
//            lblDate.text = @"今年";
//        } else {
//        }
        lblDate.text = [self.dateFormatter stringFromDate:date];
        NSLog(@"年:%zd",components.year);
    }
    else if (component == 1) // Hour
    {
//        int max = (int)[self.calendar maximumRangeOfUnit:NSCalendarUnitHour].length;
//        [lblDate setText:[NSString stringWithFormat:@"%02ld",(row % max)]]; // 02d = pad with leading zeros to 2 digits
        NSDate *aDate = [NSDate dateWithTimeInterval: row * 60 * 60 sinceDate: self.earliestPresentedDate];
        NSDateComponents *components = [self.calendar components: NSCalendarUnitEra | NSCalendarUnitMonth fromDate: aDate];
        NSLog(@"月:%zd",components.month);
//        NSDate *hourDate = [self.calendar dateFromComponents:components];
    }
    else if (component == 2) // Minutes
    {
//        int max = (int)[self.calendar maximumRangeOfUnit:NSCalendarUnitMinute].length;
//        [lblDate setText:[NSString stringWithFormat:@"%02ld",(row % max)]];
        NSDate *aDate = [NSDate dateWithTimeInterval: row * 60 * 60 sinceDate: self.earliestPresentedDate];
        NSDateComponents *components = [self.calendar components: NSCalendarUnitEra | NSCalendarUnitDay fromDate: aDate];
        NSLog(@"日:%zd",components.day);
    }
    return lblDate;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSInteger daysFromStart;
    NSDate *chosenDate;
    
    daysFromStart = [pickerView selectedRowInComponent:0];
    chosenDate = [NSDate dateWithTimeInterval:daysFromStart*24*60*60 sinceDate:self.earliestPresentedDate];
    
    NSInteger hour = [pickerView selectedRowInComponent:1];
    NSInteger minute = [pickerView selectedRowInComponent:2];
    
    // Build date out of the components we got
    NSDateComponents *components = [self.calendar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:chosenDate];
    
    components.hour = hour % 24;
    components.minute = minute % 60;
    
    self.date = [self.calendar dateFromComponents:components];
    
    if ([self.date compare:self.minDate] == NSOrderedAscending) {
        [self showDateOnPicker:self.minDate];
    } else if ([self.date compare:self.maxDate] == NSOrderedDescending) {
        [self showDateOnPicker:self.maxDate];
    }
    
    if ((self.delegate) && ([self.delegate respondsToSelector:@selector(dateChanged:)])) {
        [self.delegate dateChanged:self];
    }
}

- (void)clearSeparatorWithView:(UIView *)view
{
    if(view.subviews != 0){
        if(view.bounds.size.height < 5){
            view.backgroundColor = [UIColor clearColor];
        }
        [view.subviews enumerateObjectsUsingBlock:^(UIView *  obj, NSUInteger idx, BOOL *  stop) {
            [self clearSeparatorWithView:obj];
        }];
    }
}

#pragma mark - lazy

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"yyyy";
        _dateFormatter.locale = [NSLocale currentLocale];
    }
    return _dateFormatter;
}

- (NSMutableArray *)dateArray {
    if (!_dateArray) {
        NSMutableArray *monthArr = [NSMutableArray arrayWithCapacity:12];
        for (int i = 1; i <= 12; i ++) {
            [monthArr addObject:@(i)];
        }
        NSMutableArray *dayArr = [NSMutableArray arrayWithCapacity:31];
        for (int i = 1; i <= 31; i ++) {
            [dayArr addObject:@(i)];
        }
        
    }
    return _dateArray;
}

@end
