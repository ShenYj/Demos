//
//  ViewController.m
//  OrderResultView
//
//  Created by ecg on 2017/5/16.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "UIColor+JSExtension.h"
#import "UIImage+JSExtension.h"
#import "JSDatePickerView.h"

static CGFloat const kNavigationBarHeight = 64;

static CGFloat const kMargin = 20.f;                // 间距
static CGFloat const kStackViewHeight = 300.f;      // 容器视图的高度

@interface ViewController ()

#pragma mark - 视图控件
@property (nonatomic,strong) UIImageView    *resultImageView;
@property (nonatomic,strong) UILabel        *resultLabel;
@property (nonatomic,strong) UILabel        *paymentMethodLabel;
@property (nonatomic,strong) UILabel        *orderTotalPrice;
@property (nonatomic,strong) UIView         *stackView;
#pragma mark - 按钮
@property (nonatomic,strong) UIButton       *backButton;
@property (nonatomic,strong) UIButton       *reviewOrder;

#pragma mark - datePickerView
@property (nonatomic,strong) JSDatePickerView   *datePickerView;

@end

@implementation ViewController

#pragma mark
#pragma mark - UI

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUpOrderResultView];
}

- (void)setUpOrderResultView
{
    
    self.view.backgroundColor = [UIColor js_GrayColor:239];
    // 添加控件
    [self.view addSubview: self.stackView];
    [self.stackView addSubview: self.resultImageView];
    [self.stackView addSubview: self.resultLabel];
    [self.stackView addSubview: self.paymentMethodLabel];
    [self.stackView addSubview: self.orderTotalPrice];
    [self.view addSubview: self.backButton];
    [self.view addSubview: self.reviewOrder];
    
#pragma mark - datePickerView
    [self.view addSubview: self.datePickerView];
    [self.datePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo([UIScreen mainScreen].bounds.size.height);
        make.left.right.mas_equalTo(self.view);
    }];
    
    // 添加约束
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(kNavigationBarHeight);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(kStackViewHeight);
    }];
    [self.resultImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.stackView);
        make.top.mas_equalTo(self.stackView).mas_offset(kMargin);
    }];
    [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.resultImageView.mas_bottom).mas_offset(kMargin);
        make.left.right.mas_equalTo(self.stackView);
    }];
    [self.paymentMethodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.resultLabel.mas_bottom).mas_offset(kMargin * 2);
        make.left.right.mas_equalTo(self.stackView);
    }];
    [self.orderTotalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.paymentMethodLabel.mas_bottom).mas_offset(kMargin);
        make.left.right.mas_equalTo(self.stackView);
    }];
    
    NSArray *btns = @[self.backButton,self.reviewOrder];
    [btns mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:kMargin leadSpacing:30 tailSpacing:30];
    [btns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.stackView.mas_bottom).mas_offset(kMargin);
        make.height.mas_equalTo(44);
    }];
    
    // 数据
    self.resultLabel.text = @"支付成功 !";
    self.paymentMethodLabel.text = @"支付方式: 支付宝支付";
    NSString *orderTotalPriceSting = @"订单金额: ¥ 100.00";
    NSMutableAttributedString *mutableAttributeString = [[NSMutableAttributedString alloc] initWithString:orderTotalPriceSting];
    [mutableAttributeString addAttribute:NSForegroundColorAttributeName value:[UIColor js_colorWithHex:0xff667a] range:NSMakeRange(5, mutableAttributeString.length - 5)];
    [mutableAttributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:28] range:NSMakeRange(5, mutableAttributeString.length - 5)];
    self.orderTotalPrice.attributedText = mutableAttributeString;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark
#pragma mark - target
- (void)clickBackButton:(UIButton *)backButton
{
    // 返回
}
- (void)clickReviewOrderButton:(UIButton *)button
{
    // 查看订单
    [UIView animateWithDuration:0.25 animations:^{
        // 更新约束
        [self.datePickerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo([UIScreen mainScreen].bounds.size.height - self.datePickerView.bounds.size.height);
        }];
        [self.view layoutIfNeeded];
    }];
    
}

#pragma mark
#pragma mark - lazy

- (UIView *)stackView {
    if (!_stackView) {
        _stackView = [[UIView alloc] init];
        _stackView.backgroundColor = [UIColor whiteColor];
    }
    return _stackView;
}
- (UIImageView *)resultImageView {
    if (!_resultImageView) {
        _resultImageView = [[UIImageView alloc] init];
        _resultImageView.image = [UIImage imageNamed:@"pay_success"];
        [_resultImageView sizeToFit];
    }
    return _resultImageView;
}
- (UILabel *)resultLabel {
    if (!_resultLabel) {
        _resultLabel = [[UILabel alloc] init];
        _resultLabel.textColor = [UIColor js_colorWithHex:0x4a4a4a];
        _resultLabel.font = [UIFont systemFontOfSize:30];
        _resultLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _resultLabel;
}
- (UILabel *)paymentMethodLabel {
    if (!_paymentMethodLabel) {
        _paymentMethodLabel = [[UILabel alloc] init];
        _paymentMethodLabel.textColor = [UIColor js_colorWithHex:0x616161];
        _paymentMethodLabel.font = [UIFont systemFontOfSize:23];
        _paymentMethodLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _paymentMethodLabel;
}
- (UILabel *)orderTotalPrice {
    if (!_orderTotalPrice) {
        _orderTotalPrice = [[UILabel alloc] init];
        _orderTotalPrice.textAlignment = NSTextAlignmentCenter;
        _orderTotalPrice.textColor = [UIColor js_colorWithHex:0x616161];
        _orderTotalPrice.font = [UIFont systemFontOfSize:25];
    }
    return _orderTotalPrice;
}
- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.titleLabel.font = [UIFont systemFontOfSize:20];
        _backButton.layer.cornerRadius = 5;
        _backButton.layer.borderWidth = 2;
        _backButton.layer.borderColor = [UIColor js_RGBColorWithRed:51 withGreen:176 withBlue:250].CGColor;
        [_backButton setTitle:@"返回" forState:UIControlStateNormal];
        [_backButton setBackgroundColor:[UIColor whiteColor]];
        [_backButton setTitleColor:[UIColor js_RGBColorWithRed:51 withGreen:176 withBlue:250] forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_backButton addTarget:self action:@selector(clickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}
- (UIButton *)reviewOrder {
    if (!_reviewOrder) {
        _reviewOrder = [UIButton buttonWithType:UIButtonTypeCustom];
        _reviewOrder.titleLabel.font = [UIFont systemFontOfSize:20];
        _reviewOrder.layer.cornerRadius = 5;
        _reviewOrder.layer.borderWidth = 2;
        _reviewOrder.layer.borderColor = [UIColor js_RGBColorWithRed:51 withGreen:176 withBlue:250].CGColor;
        [_reviewOrder setTitle:@"查看订单" forState:UIControlStateNormal];
        [_reviewOrder setBackgroundColor:[UIColor js_RGBColorWithRed:51 withGreen:176 withBlue:250]];
        [_reviewOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_reviewOrder setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_reviewOrder addTarget:self action:@selector(clickReviewOrderButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reviewOrder;
}
- (JSDatePickerView *)datePickerView {
    if (!_datePickerView ) {
        _datePickerView = [[JSDatePickerView alloc] init];
    }
    return _datePickerView;
}
@end
