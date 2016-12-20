//
//  NSDate+JSIsThisYear.h
//  Weibo_Object-C
//
//  Created by ShenYj on 2016/10/24.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (JSIsThisYear)

/**
 *判断date是否是今年
 */
- (BOOL)isThisYear;
/**
 *将NSDate类型对象转换为特定格式的字符串
 */
- (NSString *)dateformatterString:(NSString *)dateformatter;

@end
