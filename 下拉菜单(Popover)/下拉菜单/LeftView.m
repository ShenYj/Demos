//
//  LeftView.m
//  下拉菜单
//
//  Created by ShenYj on 16/9/22.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "LeftView.h"
#import "Masonry.h"

@implementation LeftView {
    
    UIImageView *_imageView;
    UILabel     *_label;
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
    
    _imageView = [[UIImageView alloc] init];
    _label = [[UILabel alloc] init];
    _label.text = self.title;
    _label.font = [UIFont systemFontOfSize:13];
    //_label.backgroundColor = [UIColor greenColor];
    _label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_imageView];
    [self addSubview:_label];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self).mas_offset(5);
        make.bottom.mas_equalTo(self).mas_offset(-5);
        make.right.mas_equalTo(_label.mas_left);
        make.width.mas_equalTo(_imageView.mas_height);
    }];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(self);
    }];
    
    
}

- (void)setTitle:(NSString *)title {
    _label.text = title;
}
- (void)setImageName:(NSString *)imageName {
    _imageView.image = [UIImage imageNamed:imageName];
}

@end
