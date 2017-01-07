//
//  JSRefresh.m
//  JSRefresh_Extension
//
//  Created by ShenYj on 2016/12/6.
//  Copyright © 2016年 ShenYj. All rights reserved.
//


#import "JSRefreshControl.h"
#import "JSRefreshView.h"

/** KVO监听KeyPath */
static NSString * const kKeyPath = @"contentOffset";
/** 下拉临界值 */
static CGFloat const kJSRefreshControlCriticalValue = 60.f;

@interface JSRefreshControl ()

/** 刷新控件的父视图 */
@property (nonatomic,weak) UIScrollView *superScrollView;
/** 自定义视图 */
@property (nonatomic,strong) JSRefreshView *refreshView;


@end

@implementation JSRefreshControl

- (instancetype)init {
    self = [super init];
    if (self) {
        [self prepareRefreshView];
    }
    return self;
}

// 准备视图
- (void)prepareRefreshView {
    //self.clipsToBounds = YES;
    //self.backgroundColor = [UIColor colorWithRed:255/255.0 green:116/255.0 blue:103/255.0 alpha:1.0];
    self.backgroundColor = [UIColor clearColor];
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0);
    
    [self addSubview:self.refreshView];
    self.refreshView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLayoutConstraint *refreshViewBottomConstraint = [NSLayoutConstraint constraintWithItem:self.refreshView
                                                                                   attribute:NSLayoutAttributeBottom
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:self
                                                                                   attribute:NSLayoutAttributeBottom
                                                                                  multiplier:1
                                                                                    constant:0
                                                       ];
    [self addConstraint:refreshViewBottomConstraint];
    NSLayoutConstraint *refreshViewCenterXConstraint = [NSLayoutConstraint constraintWithItem:self.refreshView
                                                                                    attribute:NSLayoutAttributeCenterX
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:self
                                                                                    attribute:NSLayoutAttributeCenterX
                                                                                   multiplier:1
                                                                                     constant:0
                                                        ];
    [self addConstraint:refreshViewCenterXConstraint];
    NSLayoutConstraint *refreshViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.refreshView
                                                                                   attribute:NSLayoutAttributeHeight
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:nil
                                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                                  multiplier:1
                                                                                    constant:self.refreshView.bounds.size.height
                                                       ];
    [self addConstraint:refreshViewHeightConstraint];
    NSLayoutConstraint *refreshViewWidthConstraint = [NSLayoutConstraint constraintWithItem:self.refreshView
                                                                                  attribute:NSLayoutAttributeWidth
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:self.refreshView.bounds.size.width
                                                      ];
    [self addConstraint:refreshViewWidthConstraint];
}

// 将要被添加到父视图中时进行监听
-(void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if ([newSuperview isKindOfClass:[UIScrollView class]]) {
        self.superScrollView = (UIScrollView *)newSuperview;
        [self.superScrollView addObserver:self forKeyPath:kKeyPath options:NSKeyValueObservingOptionNew context:nil];
        
    }
}
// 从父视图移除时移除监听
- (void)removeFromSuperview {
    [self.superview removeObserver:self forKeyPath:kKeyPath];
    [super removeFromSuperview];
}
// KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    CGPoint point = [change[@"new"] CGPointValue];
    CGFloat height = -(self.superScrollView.contentInset.top + point.y);
    
    if(height < 0) return;
    
    self.frame = CGRectMake(0, -height, [UIScreen mainScreen].bounds.size.width, height);
    
    if (self.superScrollView.isDragging) {
        
        if (height > kJSRefreshControlCriticalValue && self.refreshView.refreshStatus == JSRefreshStatusNormal) {
            NSLog(@"大于临界值");
            self.refreshView.refreshStatus = JSRefreshStatusPulling;
        } else if (height <= kJSRefreshControlCriticalValue && self.refreshView.refreshStatus == JSRefreshStatusPulling ){
            NSLog(@"小于临界值");
            self.refreshView.refreshStatus = JSRefreshStatusNormal;
        }
        
    } else {
        if (self.refreshView.refreshStatus == JSRefreshStatusPulling ) {
            NSLog(@"准备开始刷新");
            [self beginRefresh];
            
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
    
    
    
}
// 开始刷新
- (void)beginRefresh {
    if (!self.superScrollView) {
        return;
    }
    if (self.refreshView.refreshStatus == JSRefreshStatusWillRefresh) {
        return;
    }
    
    // 设置自动以刷新控件视图状态
    self.refreshView.refreshStatus = JSRefreshStatusWillRefresh;
    // 设置表格内间距
    UIEdgeInsets inset = UIEdgeInsetsMake(self.superScrollView.contentInset.top + kJSRefreshControlCriticalValue, 0, 0, 0);
    self.superScrollView.contentInset = inset;
    
}
// 停止刷新
- (void)endRefresh {
    if (!self.superScrollView) {
        return;
    }
    if (self.refreshView.refreshStatus != JSRefreshStatusWillRefresh) {
        return;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.refreshView.refreshStatus = JSRefreshStatusNormal;
        UIEdgeInsets inset = UIEdgeInsetsMake(self.superScrollView.contentInset.top - kJSRefreshControlCriticalValue, 0, 0, 0);
        self.superScrollView.contentInset = inset;
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

#pragma mark
#pragma mark - lazy

- (JSRefreshView *)refreshView {
    if (!_refreshView) {
        _refreshView = [[JSRefreshView alloc] init];
    }
    return _refreshView;
}



@end
