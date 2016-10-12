//
//  NSString+JSCache.m
//  test
//
//  Created by ShenYj on 2016/10/12.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "NSString+JSCache.h"

@implementation NSString (JSCache)

- (instancetype)cachePath {
    
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:self];
}

@end
