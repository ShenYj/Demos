//
//  JSTableViewCell.m
//  layoutConstraintTest
//
//  Created by ShenYj on 16/9/29.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSTableViewCell.h"
#import "UIColor+JSExtension.h"
#import "Masonry.h"
#import "Top.h"
#import "Bottom.h"

@implementation JSTableViewCell {
    
    Top     *_topView;
    Bottom  *_bottomView;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self prepareView];
    }
    return self;
}

- (void)prepareView {
    
    self.backgroundColor = [UIColor whiteColor];
    
    _topView = [[Top alloc] init];
    _bottomView = [[Bottom alloc] init];
    
    [self.contentView addSubview:_topView];
    [self.contentView addSubview:_bottomView];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.contentView);
        //make.height.mas_equalTo(80);
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_topView.mas_bottom).mas_offset(0);
        make.left.right.mas_equalTo(self.contentView);
        //make.height.mas_equalTo(80);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(_bottomView);
    }];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
