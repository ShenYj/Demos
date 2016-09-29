//
//  JSTableViewCell.m
//  layoutConstraintTest
//
//  Created by ShenYj on 16/9/29.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSTableViewCell.h"

@implementation JSTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame: frame];
    if (self) {
    
        [self prepareView];
        
    }
    return self;
}

- (void)prepareView {
    
    self.contentView.backgroundColor = [UIColor greenColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
