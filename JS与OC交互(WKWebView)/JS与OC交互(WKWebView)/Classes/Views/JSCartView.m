//
//  JSCartView.m
//  Demos
//
//  Created by ShenYj on 16/9/5.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSCartView.h"
#import "Masonry.h"
#import "JSUIkitExtension.h"

@interface JSCartView ()

// 商品名称
@property (nonatomic,strong) UILabel *goodsName;
@property (nonatomic,strong) UILabel *goodsName_LB;
// 商品价格
@property (nonatomic,strong) UILabel *goodsPrice;
@property (nonatomic,strong) UILabel *goodsPrice_LB;

@end

@implementation JSCartView


- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        [self prepareView];
    }
    return self;
}

- (void)prepareView{
    
    self.backgroundColor = [UIColor js_colorWithHex:0xFFE4E1];
    [self addSubview:self.goodsName_LB];
    [self addSubview:self.goodsPrice_LB];
    [self addSubview:self.goodsName];
    [self addSubview:self.goodsPrice];
    
    NSArray *goodsNameLabel = @[self.goodsName_LB,self.goodsName];
    [goodsNameLabel mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:20 tailSpacing:20];
    [goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(100);
        make.height.mas_offset(40);
    }];
    
    NSArray *goodsPriceLabel = @[self.goodsPrice_LB,self.goodsPrice];
    [goodsPriceLabel mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:20 tailSpacing:20];
    [goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsName.mas_bottom).mas_offset(20);
        make.height.mas_offset(40);
    }];
}



- (void)setData:(NSArray *)data{
    _data = data;
    
    self.goodsName.text = data[0];
    self.goodsPrice.text = data[1];
    
}


-(UILabel *)goodsName{
    if (_goodsName == nil) {
        _goodsName = [[UILabel alloc] init];
        _goodsName.textAlignment = NSTextAlignmentCenter;
    }
    return _goodsName;
}
- (UILabel *)goodsPrice{
    if (_goodsPrice == nil) {
        _goodsPrice = [[UILabel alloc] init];
        _goodsPrice.textAlignment = NSTextAlignmentCenter;
    }
    return _goodsPrice;
}
- (UILabel *)goodsName_LB{
    if (_goodsName_LB == nil) {
        _goodsName_LB = [[UILabel alloc] init];
        _goodsName_LB.text = @"产品名称:";
    }
    return _goodsName_LB;
}
- (UILabel *)goodsPrice_LB{
    if (_goodsPrice_LB == nil) {
        _goodsPrice_LB = [[UILabel alloc] init];
        _goodsPrice_LB.text = @"产品价格:";
    }
    return _goodsPrice_LB;
}

@end
