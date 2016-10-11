//
//  JSSearchBar.m
//  搜索栏界面搭建
//
//  Created by ShenYj on 16/9/20.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSSearchBar.h"

@interface JSSearchBar ()

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UITextField *textField;


@end

@implementation JSSearchBar

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        [self prepareView];
    }
    return self;
}

- (void)prepareView {
    }

- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (id obj in self.subviews) {
        
        NSLog(@"%@",[obj class]);
        if ([obj isKindOfClass:[UITextField class]]) {
        }
    }
    
}

@end
