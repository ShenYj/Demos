//
//  NSString+JSExtension.m
//  MajorForum
//
//  Created by ShenYj on 16/8/17.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "NSString+JSExtension.h"

@implementation NSString (Characters)

//将汉字转换为拼音
- (instancetype)js_pinyinOfString{
    
    NSMutableString * string = [[NSMutableString alloc] initWithString:self];
    
    //    CFRange range = CFRangeMake(0, 1);
    //&range
    //汉字转换为拼音,并去除音调
    
    if ( ! CFStringTransform((__bridge CFMutableStringRef) string,NULL, kCFStringTransformMandarinLatin, NO) ||
        
        ! CFStringTransform((__bridge CFMutableStringRef) string, NULL, kCFStringTransformStripDiacritics, NO)) {
        
        return @"";
        
    }
    return string;//返回转换后带空格的拼音字符串
    
}

//返回不带空格的字符串
- (instancetype)js_pinyinWithoutBlankOfString{
    
    NSMutableString * string = [[NSMutableString alloc] initWithString:self];
    
    if ( ! CFStringTransform((__bridge CFMutableStringRef) string,NULL, kCFStringTransformMandarinLatin, NO) ||
        
        ! CFStringTransform((__bridge CFMutableStringRef) string, NULL, kCFStringTransformStripDiacritics, NO)) {
        
        return @"";
        
    }
    //返回转换后不带空格的拼音字符串
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}

//汉字转换为拼音后，返回大写的首字母
- (instancetype)js_firstCharacterOfString{
    
    NSMutableString * first = [[NSMutableString alloc] initWithString:[self substringWithRange:NSMakeRange(0, 1)]];
    
    CFRange range = CFRangeMake(0, 1);
    // 汉字转换为拼音,并去除音调
    
    if ( ! CFStringTransform((__bridge CFMutableStringRef) first, &range, kCFStringTransformMandarinLatin, NO) ||
        
        ! CFStringTransform((__bridge CFMutableStringRef) first, &range, kCFStringTransformStripDiacritics, NO)) {
        
        return @"";
        
    }
    
    NSString * result;
    result = [first substringWithRange:NSMakeRange(0, 1)];
    return result.uppercaseString;
    
}

@end
