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
@end




@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.loopView];
    [self.loopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(64);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(0);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
