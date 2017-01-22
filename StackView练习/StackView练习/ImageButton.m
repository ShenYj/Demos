//
//  ImageButton.m
//  StackView练习
//
//  Created by ShenYj on 2017/1/22.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "ImageButton.h"

@implementation ImageButton


- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

// 从IB中加载的按钮,会执行此方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

@end
