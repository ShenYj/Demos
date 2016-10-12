//
//  JSApps.m
//  test
//
//  Created by ShenYj on 2016/10/12.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "JSApps.h"

@implementation JSApps

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)appsWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}

+ (NSArray<JSApps *> *)loadDataWithPlistName:(NSString *)plistName {
    
    NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:plistName ofType:@"plist"]];
    
    NSMutableArray *mArr = [NSMutableArray array];
    
    for (NSDictionary *dict in arr) {
        
        JSApps *app = [JSApps appsWithDict:dict];
        
        [mArr addObject:app];
    }
    
    return mArr.copy;
}

@end
