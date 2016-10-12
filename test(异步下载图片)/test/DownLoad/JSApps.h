//
//  JSApps.h
//  test
//
//  Created by ShenYj on 2016/10/12.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSApps.h"

@interface JSApps : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *download;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)appsWithDict:(NSDictionary *)dict;
+ (NSArray <JSApps *>*)loadDataWithPlistName:(NSString *)plistName;

@end
