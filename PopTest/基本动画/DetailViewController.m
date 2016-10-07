//
//  DetailViewController.m
//  基本动画
//
//  Created by ShenYj on 16/10/7.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic) CALayer *redLayer;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
    
    // 1.创建CALayer
    self.redLayer = [CALayer layer];
    
    // 2.设置大小位置
    self.redLayer.bounds = CGRectMake(0, 0, 100, 100);
    self.redLayer.position = self.view.center;
    
    // 3.设置背景色
    self.redLayer.backgroundColor = [UIColor redColor].CGColor;
    
    // 4.添加
    [self.view.layer addSublayer:self.redLayer];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    [self scale];
    
}

#pragma mark - 旋转

#pragma mark - 缩放
- (void)scale {
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    basicAnimation.duration = 2;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    
    basicAnimation.toValue = @(0.5);
    
    [self.redLayer addAnimation:basicAnimation forKey:@"transformScale"];
    
}


#pragma mark - 平移
- (void)move {

    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    basicAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    basicAnimation.duration = 2;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    
    [self.redLayer addAnimation:basicAnimation forKey:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
