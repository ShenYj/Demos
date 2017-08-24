//
//  JSProgressAlert.m
//  ProgressAlert
//
//  Created by ecg on 2017/8/24.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import "JSProgressAlert.h"
#import "Masonry.h"

@implementation JSProgressAlert

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getMessageLabelAndTitleLabel];
    [self setupView];
}

- (void)setupView
{
    [self.view addSubview: self.progressView];
    self.progressView.progress = 0.8;
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.baseView).mas_offset(10);
        make.right.mas_equalTo(self.baseView).mas_offset(-10);
        make.centerY.mas_equalTo(self.baseView);
    }];
}

- (void)getMessageLabelAndTitleLabel
{
    UIView *subView1 = self.view.subviews[0];
    UIView *subView2 = subView1.subviews[0];
    UIView *subView3 = subView2.subviews[0];
    UIView *subView4 = subView3.subviews[0];
    UIView *subView5 = subView4.subviews[0];
    // 取title和message：
    self.titleLabel = subView5.subviews[0];
    self.messgeLabel = subView5.subviews[1];
    // 取底视图
    self.baseView = subView3;
    NSLog(@"%zd",subView5.subviews.count);
    NSLog(@"%@",subView5.subviews);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazy

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] init];
        _progressView.progressTintColor = [UIColor redColor];
        _progressView.trackTintColor = [UIColor grayColor];
        _progressView.progressViewStyle = UIProgressViewStyleDefault;
    }
    return _progressView;
}


@end
