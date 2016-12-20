//
//  NSDate+JSIsThisYear.m
//  Weibo_Object-C
//
//  Created by ShenYj on 2016/10/24.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "NSDate+JSIsThisYear.h"
#import "JSDateFormatter.h"

@implementation NSDate (JSIsThisYear)

// 判断传入的时间是否是今年
- (BOOL)isThisYear {
    
    [JSDateFormatter sharedDateFormatterManager].dateFormat = @"yyyy";
    // 取出日期的年并转成字符串
    NSString *dateYearString = [[JSDateFormatter sharedDateFormatterManager] stringFromDate:self];
    // 获取当前时间,同样取出年转为字符串
    NSDate *currentDate = [NSDate date];
    NSString *currentYearString = [[JSDateFormatter sharedDateFormatterManager] stringFromDate:currentDate];
    
    // 对比取出的年是否相同,判断是否属于今年
    if ([dateYearString isEqualToString:currentYearString]) {
        
        return YES;
        
    } else {
        
        return NO;
    }
    
}

// 将当前date转换为特定格式的字符串date
- (NSString *)dateformatterString:(NSString *)dateformatter {
    
    [JSDateFormatter sharedDateFormatterManager].dateFormat = dateformatter;
    
    return [[JSDateFormatter sharedDateFormatterManager] stringFromDate:self];
}


@end
