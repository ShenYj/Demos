//
//  DetailViewController.m
//  关键帧动画
//
//  Created by ShenYj on 2016/10/7.
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
    
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    keyFrameAnimation.duration = 2;
    keyFrameAnimation.removedOnCompletion = NO;
    keyFrameAnimation.fillMode = kCAFillModeForwards;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, self.view.center.y - 200, self.view.bounds.size.width - 200, 400)];
    
    keyFrameAnimation.path = bezierPath.CGPath;
    
    keyFrameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.redLayer addAnimation:keyFrameAnimation forKey:@"position"];
    
}

- (void)test {
    
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    keyFrameAnimation.duration = 2;
    keyFrameAnimation.removedOnCompletion = NO;
    keyFrameAnimation.fillMode = kCAFillModeForwards;
    
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(self.view.center.x - 100, self.view.center.y - 100)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(self.view.center.x + 100, self.view.center.y - 100)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(self.view.center.x + 100, self.view.center.y + 100)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(self.view.center.x - 100, self.view.center.y + 100)];
    
    keyFrameAnimation.values = @[value1,value2,value3,value4,value1];
    
    [self.redLayer addAnimation:keyFrameAnimation forKey:@"position"];
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
