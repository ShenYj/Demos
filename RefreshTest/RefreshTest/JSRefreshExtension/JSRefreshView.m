//
//  JSRefreshView.m
//  JSRefresh_Extension
//
//  Created by ShenYj on 2016/12/6.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "JSRefreshView.h"

/** 最左侧控件距离父控件的间距(LeftImageView) */
static CGFloat const kLeftMargin = 20.f;
/** 左侧图片框的宽高 */
static CGFloat const kLeftImageViewWidth = 15.f;
static CGFloat const kLeftImageViewHeight = 40.f;
/** 文本描述内容 */
static NSString * const kDetailTextLabelContent = @"下拉刷新...";
/** 下拉刷新视图(JSRefreshView)自身宽高参数 */
static CGFloat const kRefreshViewWidth = 220.f;
static CGFloat const kRefreshViewHeight = 60.f;


@interface JSRefreshView ()

/** 左侧图片框 */
@property (nonatomic,strong) UIImageView *leftImageView;
/** 文字描述 */
@property (nonatomic,strong) UILabel *descriptionLabel;
/** 指示器 */
@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;
/** 右侧图片框 */
@property (nonatomic,strong) UIImageView *backgroundImageView;

@end

@implementation JSRefreshView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self prepareRefreshView];
    }
    return self;
}

- (void)setRefreshStatus:(JSRefreshStatus)refreshStatus {
    _refreshStatus = refreshStatus;
    /**
     1.iOS系统中UIView封装的旋转动画,默认顺时针旋转(使用-M_PI也是一样)
     2.就近原则
     */
    switch (refreshStatus) {
        case JSRefreshStatusNormal:
            {
                self.leftImageView.hidden = NO;
                [self.indicatorView stopAnimating];
                self.descriptionLabel.text = @"继续使劲拉...";
                [UIView animateWithDuration:0.25 animations:^{
                    self.leftImageView.transform = CGAffineTransformIdentity;
                }];
            }
            break;
        case JSRefreshStatusPulling:
            {
                self.descriptionLabel.text = @"松手将刷新...";
                [UIView animateWithDuration:0.25 animations:^{
                    // 就近原则:同方向旋转,可以调整一个非常小的数字,-0.001,使其小于180°,返回的时候根据就近原则,按照原路返回
                    self.leftImageView.transform = CGAffineTransformMakeRotation(M_PI-0.001);
                }];
            }
            break;
        case JSRefreshStatusWillRefresh:
            self.leftImageView.hidden = YES;
            self.descriptionLabel.text = @"正在刷新中...";
            [self.indicatorView startAnimating];
            
            break;
        default:
            break;
    }
}

- (void)prepareRefreshView {
    
    self.frame = CGRectMake(0, 0, kRefreshViewWidth, kRefreshViewHeight);
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.leftImageView];
    [self addSubview:self.descriptionLabel];
    [self addSubview:self.indicatorView];
    
    // 设置刷新控件初始状态
    self.refreshStatus = JSRefreshStatusNormal;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.leftImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *backgroundImageViewBottomConstraint = [NSLayoutConstraint constraintWithItem:self.backgroundImageView
                                                                                           attribute:NSLayoutAttributeBottom
                                                                                           relatedBy:NSLayoutRelationEqual
                                                                                              toItem:self
                                                                                           attribute:NSLayoutAttributeBottom
                                                                                          multiplier:1
                                                                                            constant:0
                                                               ];
    [self addConstraint:backgroundImageViewBottomConstraint];
    NSLayoutConstraint *backgroundImageViewCenterXConstraint = [NSLayoutConstraint constraintWithItem:self.backgroundImageView
                                                                                            attribute:NSLayoutAttributeCenterX
                                                                                            relatedBy:NSLayoutRelationEqual
                                                                                               toItem:self
                                                                                            attribute:NSLayoutAttributeCenterX
                                                                                           multiplier:1
                                                                                             constant:0
                                                                ];
    [self addConstraint:backgroundImageViewCenterXConstraint];
    NSLayoutConstraint *backgrouundImageViewWidthConstraint = [NSLayoutConstraint constraintWithItem:self.backgroundImageView
                                                                                           attribute:NSLayoutAttributeWidth
                                                                                           relatedBy:NSLayoutRelationEqual
                                                                                              toItem:nil
                                                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                                                          multiplier:1
                                                                                            constant:[UIScreen mainScreen].bounds.size.width
                                                               ];
    [self addConstraint:backgrouundImageViewWidthConstraint];
    NSLayoutConstraint *backgroundImageViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.backgroundImageView
                                                                                           attribute:NSLayoutAttributeHeight
                                                                                           relatedBy:NSLayoutRelationEqual
                                                                                              toItem:nil
                                                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                                                          multiplier:1
                                                                                            constant:self.backgroundImageView.bounds.size.height
                                                               ];
    [self addConstraint:backgroundImageViewHeightConstraint];
    
    
    NSLayoutConstraint *leftImageViewLeftConstraint = [NSLayoutConstraint constraintWithItem:self.leftImageView
                                                                                   attribute:NSLayoutAttributeLeft
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:self
                                                                                   attribute:NSLayoutAttributeLeft
                                                                                  multiplier:1
                                                                                    constant:kLeftMargin
                                                       ];
    [self addConstraint:leftImageViewLeftConstraint];
    NSLayoutConstraint *leftImageViewCenterYConstraint = [NSLayoutConstraint constraintWithItem:self.leftImageView
                                                                                      attribute:NSLayoutAttributeCenterY
                                                                                      relatedBy:NSLayoutRelationEqual
                                                                                         toItem:self
                                                                                      attribute:NSLayoutAttributeCenterY
                                                                                     multiplier:1
                                                                                       constant:0
                                                          ];
    [self addConstraint:leftImageViewCenterYConstraint];
    NSLayoutConstraint *leftImageViewWidthConstraint = [NSLayoutConstraint constraintWithItem:self.leftImageView
                                                                                    attribute:NSLayoutAttributeWidth
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:nil
                                                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                                                   multiplier:1
                                                                                     constant:kLeftImageViewWidth];
    [self addConstraint:leftImageViewWidthConstraint];
    NSLayoutConstraint *leftImageViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.leftImageView
                                                                                     attribute:NSLayoutAttributeHeight
                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                        toItem:nil
                                                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                                                    multiplier:1
                                                                                      constant:kLeftImageViewHeight
                                                         ];
    [self addConstraint:leftImageViewHeightConstraint];
    
    NSLayoutConstraint *descriptionLabelLeftConstraint = [NSLayoutConstraint constraintWithItem:self.descriptionLabel
                                                                                      attribute:NSLayoutAttributeLeft
                                                                                      relatedBy:NSLayoutRelationEqual
                                                                                         toItem:self.leftImageView
                                                                                      attribute:NSLayoutAttributeRight
                                                                                     multiplier:1 constant:kLeftMargin
                                                          ];
    [self addConstraint:descriptionLabelLeftConstraint];
    NSLayoutConstraint *descriptionLabelCenterYConstrait = [NSLayoutConstraint constraintWithItem:self.descriptionLabel
                                                                                        attribute:NSLayoutAttributeCenterY
                                                                                        relatedBy:NSLayoutRelationEqual
                                                                                           toItem:self
                                                                                        attribute:NSLayoutAttributeCenterY
                                                                                       multiplier:1
                                                                                         constant:0
                                                            ];
    [self addConstraint:descriptionLabelCenterYConstrait];
    
    NSLayoutConstraint *indicatorViewCenterX = [NSLayoutConstraint constraintWithItem:self.indicatorView
                                                                            attribute:NSLayoutAttributeCenterX
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.leftImageView
                                                                            attribute:NSLayoutAttributeCenterX
                                                                           multiplier:1
                                                                             constant:0
                                                ];
    [self addConstraint:indicatorViewCenterX];
    NSLayoutConstraint *indicatorViewCenterY = [NSLayoutConstraint constraintWithItem:self.indicatorView
                                                                            attribute:NSLayoutAttributeCenterY
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.leftImageView
                                                                            attribute:NSLayoutAttributeCenterY
                                                                           multiplier:1
                                                                             constant:0
                                                ];
    [self addConstraint:indicatorViewCenterY];
    
    
    
}


#pragma mark 
#pragma mark - lazy

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"assets.bundle" ofType:nil];
        NSBundle *assetsBundle = [NSBundle bundleWithPath:path];
        _leftImageView.image = [UIImage imageNamed:@"arrow.png" inBundle:assetsBundle compatibleWithTraitCollection:nil];
    }
    return _leftImageView;
}
- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.font = [UIFont systemFontOfSize:16];
        _descriptionLabel.textColor = [UIColor blackColor];
        _descriptionLabel.textAlignment = NSTextAlignmentCenter;
        _descriptionLabel.text = kDetailTextLabelContent;
        [_descriptionLabel sizeToFit];
    }
    return _descriptionLabel;
}
- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.color = [UIColor purpleColor];
    }
    return _indicatorView;
}
- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"assets.bundle" ofType:nil];
        NSBundle *assetsBundle = [NSBundle bundleWithPath:path];
        UIImage *image = [UIImage imageNamed:@"background.jpg" inBundle:assetsBundle compatibleWithTraitCollection:nil];
        CGFloat imageNewHeight = [UIScreen mainScreen].bounds.size.width * image.size.height / image.size.width;
        CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, imageNewHeight);
        UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0);
        [image drawInRect:rect];
        UIImage *getImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        _backgroundImageView.image = getImage;
        [_backgroundImageView sizeToFit];
    }
    return _backgroundImageView;
}

@end
