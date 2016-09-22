//
//  RightView.m
//  下拉菜单
//
//  Created by ShenYj on 16/9/22.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "RightView.h"
#import "Masonry.h"
#import "UserNameListTableViewController.h"

@implementation RightView {
    
    UIButton *_button;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        [self prepareView];
    }
    return self;
}

- (void)prepareView {
    
    _button = [[UIButton alloc] init];
    [_button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
}

- (void)setImageName:(NSString *)imageName {
    
    [_button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

- (void)setImageNameSel:(NSString *)imageNameSel {
    
    [_button setImage:[UIImage imageNamed:imageNameSel] forState:UIControlStateSelected];
}

- (void)clickButton:(UIButton *)sender {
    
    sender.selected = !sender.isSelected;
    
    if (self.handler) {
        self.handler(sender);
    }
    
    switch (sender.buttonType) {
        case RightViewButtonTypeUserName:
            NSLog(@"RightViewButtonTypeUserName");
            break;
        case RightViewButtonTypePassWord:
            NSLog(@"RightViewButtonTypePassWord");
            break;
        default:
            break;
    }
    
}


@end
