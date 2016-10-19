//
//  JSLoopViewCell.m
//  轮播器demo
//
//  Created by ShenYj on 2016/10/19.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "JSLoopViewCell.h"

@interface JSLoopViewCell ()

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UILabel *detailLabel;

@end

@implementation JSLoopViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView).mas_offset(0);
        }];
        
        
//        UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//        UIVisualEffectView *visualEffectView =[[UIVisualEffectView alloc] initWithEffect:blurEffect];
//        [self.imageView addSubview:visualEffectView];
//        [visualEffectView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(self.imageView);
//        }];
        
        [self.imageView addSubview:self.detailLabel];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.imageView);
        }];
        
    }
    return self;
}

- (void)setImageUrlString:(NSString *)imageUrlString {
    
    NSURL *imageUrl = [NSURL URLWithString:imageUrlString];
    [self.imageView yy_setImageWithURL:imageUrl options:YYWebImageOptionShowNetworkActivity];
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    
    self.detailLabel.text = @(currentIndex).description;
}

#pragma mark 
#pragma mark - lazy

- (UIImageView *)imageView {
    
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

- (UILabel *)detailLabel {
    
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = [UIColor purpleColor];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.font = [UIFont systemFontOfSize:44];
    }
    return _detailLabel;
}

@end
