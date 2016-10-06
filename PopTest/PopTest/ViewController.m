//
//  ViewController.m
//  PopTest
//
//  Created by ShenYj on 16/10/5.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "ViewController.h"
#import "JSPopButton.h"
#import <POP.h>

extern CGFloat kButtonSize;

@interface ViewController ()

@property (nonatomic) UIView *circleView;
@property (nonatomic) NSArray *buttonsArr;

@property (nonatomic) JSPopButton *button_0;
@property (nonatomic) JSPopButton *button_1;
@property (nonatomic) JSPopButton *button_2;
@property (nonatomic) JSPopButton *button_3;
@property (nonatomic) JSPopButton *button_4;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"pop展示" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBarButtonItem:)];
    
    [self.view addSubview:self.circleView];
    [self.view insertSubview:self.button_0 belowSubview:self.circleView];
    [self.view insertSubview:self.button_1 belowSubview:self.circleView];
    [self.view insertSubview:self.button_2 belowSubview:self.circleView];
    [self.view insertSubview:self.button_3 belowSubview:self.circleView];
    [self.view insertSubview:self.button_4 belowSubview:self.circleView];
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        
        CGPoint point = [touch locationInView:touch.view];
        
        if (CGRectContainsPoint(self.circleView.frame, point)) {
            
            for (JSPopButton *button in self.buttonsArr) {
                
                button.layer.transform = CATransform3DIdentity;
            }
            
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -
#pragma mark pop动画
- (void)clickRightBarButtonItem:(UIBarButtonItem *)sender {
    
    
    CGFloat angel = M_PI * 2 / 5;
    int i = 0;
    
    for (JSPopButton *button in self.buttonsArr) {
        
        i ++;
        
        CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
        
        groupAnimation.repeatCount = 0;
        groupAnimation.duration = 0.3;
        groupAnimation.removedOnCompletion = NO;
        groupAnimation.fillMode = kCAFillModeForwards;
        
//#pragma mark - 设置z轴旋转
//        POPBasicAnimation *rotationAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
//        
//        rotationAnimation.toValue = @(angel * i);
//        
//        [button.layer pop_addAnimation:rotationAnimation forKey:nil];
//        
//#pragma mark - 设置位移
//        POPBasicAnimation *translateAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerTranslationXY];
//        
//        translateAnimation.toValue = @(100);
//        
//        [button.layer pop_addAnimation:translateAnimation forKey:nil];
        
        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        rotationAnimation.toValue = @(angel * i);
        
        
        CABasicAnimation *transLateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
        transLateAnimation.toValue = @(100);
        
        groupAnimation.animations = @[rotationAnimation,transLateAnimation];
        
        [button.layer addAnimation:groupAnimation forKey:nil];
        
        
    }
    
    
    
    
    
}


#pragma mark -
#pragma mark 懒加载

- (UIView *)circleView {
    
    if (_circleView == nil) {
        _circleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _circleView.layer.position = self.view.center;
        _circleView.layer.cornerRadius = 50;
        _circleView.clipsToBounds = YES;
        _circleView.backgroundColor = [UIColor redColor];
    }
    return _circleView;
}

- (NSArray *)buttonsArr {
    
    if (_buttonsArr == nil) {
        _buttonsArr = @[self.button_0,self.button_1,self.button_2,self.button_3,self.button_4];
    }
    return _buttonsArr;
}

- (JSPopButton *)button_0 {
    
    if (_button_0 == nil) {
        _button_0 = [[JSPopButton alloc] initWithName:@"0"];
        _button_0.layer.position = self.circleView.center;
    }
    return _button_0;
}

- (JSPopButton *)button_1 {
    
    if (_button_1 == nil) {
        _button_1 = [[JSPopButton alloc] initWithName:@"0"];
        _button_1.layer.position = self.circleView.center;
    }
    return _button_1;
}

- (JSPopButton *)button_2 {
    
    if (_button_2 == nil) {
        _button_2 = [[JSPopButton alloc] initWithName:@"0"];
        _button_2.layer.position = self.circleView.center;
    }
    return _button_2;
}

- (JSPopButton *)button_3 {
    
    if (_button_3 == nil) {
        _button_3 = [[JSPopButton alloc] initWithName:@"0"];
        _button_3.layer.position = self.circleView.center;
    }
    return _button_3;
}

- (JSPopButton *)button_4 {
    
    if (_button_4 == nil) {
        _button_4 = [[JSPopButton alloc] initWithName:@"0"];
        _button_4.layer.position = self.circleView.center;
    }
    return _button_4;
}

@end
