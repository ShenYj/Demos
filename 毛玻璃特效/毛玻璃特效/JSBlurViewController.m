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

@end

@implementation JSBlurViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 毛玻璃效果
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    [self.imageView addSubview:visualEffectView];
    [visualEffectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(64, 0, 50, 0));
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
