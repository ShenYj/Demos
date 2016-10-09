//
//  ViewController.m
//  毛玻璃特效
//
//  Created by ShenYj on 2016/10/9.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "JSBlurViewController.h"
#import <Masonry.h>
#import "YYWebImage.h"

@interface JSBlurViewController ()

@property (nonatomic) UIImageView *imageView;

@property (nonatomic) UILabel *detailLabel;

@end

@implementation JSBlurViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    // 毛玻璃效果
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    [self.imageView addSubview:visualEffectView];
    [visualEffectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    // 内容鲜活
    UIVibrancyEffect *brancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    UIVisualEffectView *brancyVisualEffectView = [[UIVisualEffectView alloc] initWithEffect:brancyEffect];
    
    [self.view addSubview:brancyVisualEffectView];
    [brancyVisualEffectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [brancyVisualEffectView.contentView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(brancyVisualEffectView);
    }];
    
}

#pragma mark - lazy

- (UIImageView *)imageView {
    
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_imageView yy_setImageWithURL:[NSURL URLWithString:@"http://hbimg.b0.upaiyun.com/0be541f29fcacb230ed62352765bdb8c794ff434536b3-KhBXDw_fw658"] placeholder:nil];
    }
    return _imageView;
}

- (UILabel *)detailLabel {
    
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.font = [UIFont systemFontOfSize:16];
        _detailLabel.textColor = [UIColor blackColor];
        _detailLabel.numberOfLines = 0;
        _detailLabel.text = @"后院门的玻璃被主人拆掉了，然而狗狗Sophie还不知道，在主人的呼唤下，傻汪站在门外哼哼唧唧的就是不敢进来，哪怕主人已经伸手过去摸过它的头了！[笑cry]它跟玻璃门一定是发生过什么故事";
    }
    return _detailLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
