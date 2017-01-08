//
//  HeaderView.m
//  RefreshTest
//
//  Created by ShenYj on 2017/1/7.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "NavigationBar.h"

@implementation NavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareView];
    }
    return self;
}

- (void)prepareView {
    self.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.headerView1];
    [self addSubview:self.headerView2];
}

#pragma mark
#pragma mark - lazy

- (UIView *)headerView1 {
    if (!_headerView1) {
        _headerView1 = [[UIView alloc] initWithFrame:self.bounds];
        _headerView1.backgroundColor = [UIColor blueColor];
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        [_headerView1 addSubview:label];
        label.text = @"HeaderView1";
        label.textAlignment = NSTextAlignmentRight;
    }
    return _headerView1;
}

- (UIView *)headerView2 {
    if (!_headerView2) {
        _headerView2 = [[UIView alloc] initWithFrame:self.bounds];
        _headerView2.backgroundColor = [UIColor greenColor];
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        [_headerView2 addSubview:label];
        label.text = @"HeaderView1";
        label.textAlignment = NSTextAlignmentLeft;
    }
    return _headerView2;
}

@end

