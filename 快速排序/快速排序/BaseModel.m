//
//  BaseModel.m
//  快速排序
//
//  Created by ShenYj on 2017/3/1.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (NSString *)description {
    NSArray *keys = @[@"evaluation"];
    return [self dictionaryWithValuesForKeys:keys].description;
}

@end
