//
//  ViewController.m
//  轮播器demo
//
//  Created by ShenYj on 2016/10/19.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "ViewController.h"
#import "JSLoopView.h"

@interface ViewController ()

@property (nonatomic) NSArray *datas;
@property (nonatomic) JSLoopView *loopView;
@property (nonatomic) UIPageControl *pageControl;
@end




@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.loopView];
    [_loopView addSubview:self.pageControl];
    
    __weak typeof(self) weakSelf = self;
    [self.loopView setCompeletionHandler:^(NSInteger idx) {
        weakSelf.pageControl.currentPage = idx;
    }];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(-10);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.loopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(64);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(0);
    }];
    
}


#pragma mark
#pragma mark - Lazy
- (NSArray *)datas {
    
    if (_datas == nil) {
        _datas = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"imgSources" ofType:@"plist"]];
    }
    return _datas;
}

- (JSLoopView *)loopView {
    
    if (_loopView == nil) {
        _loopView = [[JSLoopView alloc] init];
        _loopView.imageUrls = self.datas;
        
    }
    return _loopView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.numberOfPages = self.datas.count;
        _pageControl.currentPage = 0;
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.bounds = CGRectMake(0, 0, self.loopView.bounds.size.width, 40);
    }
    return _pageControl;
}

@end
