//
//  Bottom.m
//  layoutConstraintTest
//
//  Created by ShenYj on 16/9/29.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "Bottom.h"
#import "Masonry.h"
#import "UIColor+JSExtension.h"


@implementation Bottom {
    
    UIView    *_view1;
    UIView    *_view2;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor greenColor];
        
        [self prepareView];
        
    }
    return self;
}

- (void)prepareView {
    
    _view1 = [[UIView alloc] init];
    _view2 = [[UIView alloc] init];
    
    _view1.backgroundColor = [UIColor js_randomColor];
    _view2.backgroundColor = [UIColor js_randomColor];
    
    [self addSubview:_view1];
    [self addSubview:_view2];
    
    [_view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(10);
        make.left.mas_equalTo(self).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    [_view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_view1.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(_view1);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_view2).mas_offset(10);
    }];
    
}


@end
