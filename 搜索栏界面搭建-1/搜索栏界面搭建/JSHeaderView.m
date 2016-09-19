//
//  JSHeaderView.m
//  搜索栏界面搭建
//
//  Created by ShenYj on 16/9/19.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSHeaderView.h"
#import "Masonry.h"

@implementation JSHeaderView{  
    
    UILabel     *_label;
    UILabel     *_detailLabel;
    UIButton    *_button;
    NSArray     *_data;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        [self prepareView];
    }
    return self;
}

- (void)prepareView {
    
    self.backgroundColor = [UIColor colorWithRed:198/255.0 green:198/255.0 blue:203/255.0 alpha:1.0];
    
    _label = [[UILabel alloc] init];
    _label.backgroundColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:26];
    _label.text = @"搜索视图Demo";
    [self addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(10);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(30);
    }];
    
    _detailLabel = [[UILabel alloc] init];
    _detailLabel.backgroundColor = [UIColor whiteColor];
    _detailLabel.textAlignment = NSTextAlignmentCenter;
    _detailLabel.font = [UIFont systemFontOfSize:15];
    _detailLabel.textColor = [UIColor purpleColor];
    _detailLabel.numberOfLines = 0;
    _detailLabel.text = @"这是一个TableViewController\n通过设置了TableView向下偏移,在导航栏处插入了此顶部视图\n";
    [self addSubview:_detailLabel];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_label.mas_bottom);
        make.left.right.mas_equalTo(self);
//        make.bottom.mas_equalTo(self).mas_offset(-44);
        make.bottom.mas_equalTo(self).mas_offset(-5);
    }];
    
//    _button = [[UIButton alloc] init];
//    _button.titleLabel.font = [UIFont systemFontOfSize:16];
//    [_button setTitle:@"搜索" forState:UIControlStateNormal];
//    [_button setBackgroundColor:[UIColor magentaColor]];
//    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_button addTarget:self action:@selector(clickSearchButton:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self addSubview:_button];
//    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self).mas_offset(-8);
//        make.top.mas_equalTo(_detailLabel.mas_bottom).mas_offset(8);
//        make.bottom.mas_equalTo(self).mas_offset(-8);
//        make.width.mas_equalTo(46);
//    }];
//    
    
}


- (void)clickSearchButton:(UIButton *)sender {
    
    NSLog(@"%s",__func__);
}


@end
