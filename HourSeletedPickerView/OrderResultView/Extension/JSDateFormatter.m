//
//  JSDateFormatter.m
//  Weibo_Object-C
//
//  Created by ShenYj on 2016/10/24.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSDateFormatter.h"

static JSDateFormatter *_instanceType = nil;

@implementation JSDateFormatter

+ (instancetype)sharedDateFormatterManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instanceType = [[self alloc] init];
        // 设置地区 (不设置真机下可能出现时间不准确,模拟器不受影响)
        _instanceType.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    });
    return _instanceType;
}

@end
