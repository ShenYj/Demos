//
//  ViewController.m
//  属性动画器(ios10)
//
//  Created by ShenYj on 2017/2/14.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (nonatomic) UIViewPropertyAnimator *propertyAnimator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.propertyAnimator = [[UIViewPropertyAnimator alloc] initWithDuration:2 curve:UIViewAnimationCurveLinear animations:^{
        self.greenView.transform = CGAffineTransformRotate(self.greenView.transform, M_PI_4);
    }];
}

- (IBAction)start:(id)sender {
    
    [self.propertyAnimator startAnimation];
}

- (IBAction)pause:(id)sender {
    
    [self.propertyAnimator pauseAnimation];
}

- (IBAction)continueAnimation:(id)sender {
    UISpringTimingParameters *sprinTimingParas = [[UISpringTimingParameters alloc] initWithDampingRatio:0.3];
    [self.propertyAnimator continueAnimationWithTimingParameters:sprinTimingParas durationFactor:1];
}


- (IBAction)end:(id)sender {
    
    [self.propertyAnimator stopAnimation:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
