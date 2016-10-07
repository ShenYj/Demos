//
//  DetailViewController.m
//  组动画
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.duration = 5;
    
    CABasicAnimation *basicAnimationScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicAnimationScale.toValue = @(0.5);

    CABasicAnimation *basicAnimationRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    basicAnimationRotation.byValue = @(M_PI_2 * 0.5);
    
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, self.view.center.y - 200, self.view.bounds.size.width - 200, 400)];
    keyFrameAnimation.path = bezierPath.CGPath;
    keyFrameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    groupAnimation.animations = @[basicAnimationScale,basicAnimationRotation,keyFrameAnimation];
    
    [self.redLayer addAnimation:groupAnimation forKey:nil];
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
