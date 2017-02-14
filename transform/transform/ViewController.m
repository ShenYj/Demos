//
//  ViewController.m
//  transform
//
//  Created by ShenYj on 2017/2/10.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) UIView *redView;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [UIView animateWithDuration:3 animations:^{
//        self.redView.transform = CGAffineTransformRotate(self.redView.transform, M_PI_4);
//        self.redView.transform = CGAffineTransformTranslate(self.redView.transform, 100, 100);
        
        // 混合变换
//        CGAffineTransform transForm1 = CGAffineTransformRotate(self.redView.transform, M_PI_4);
//        CGAffineTransform transFrom2 = CGAffineTransformTranslate(self.redView.transform, 100, 100);
//        CGAffineTransform transForm = CGAffineTransformConcat(transForm1, transFrom2);
//        self.redView.transform = transForm;
        
        // 变换的顺序,会影响到变换的结果
//        CGAffineTransform transform = CGAffineTransformIdentity; //create a new transform
//        transform = CGAffineTransformTranslate(transform, 200, 0); //translate by 200 points
//        transform = CGAffineTransformScale(transform, 0.5, 0.5); //scale by 50%
//        transform = CGAffineTransformRotate(transform, M_PI_4); //rotate by 45 degrees
//        //apply transform to layer
//        self.redView.transform = transform;
        
        //CGAffineTransform transform = CGAffineTransformIdentity; //create a new transform
//        CGAffineTransform transform1 = CGAffineTransformTranslate(self.redView.transform, 200, 0); //translate by 200 points
//        CGAffineTransform transform2 = CGAffineTransformScale(self.redView.transform, 0.5, 0.5); //scale by 50%
//        CGAffineTransform transform3 = CGAffineTransformRotate(self.redView.transform, M_PI_4); //rotate by 45 degrees
//        CGAffineTransform transform = CGAffineTransformConcat(transform1, transform2);
//        transform = CGAffineTransformConcat(transform, transform3);
//        //apply transform to layer
//        self.redView.transform = transform;
        
        self.redView.transform = CGAffineTransformMakeShear(1, 0);
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 斜边切换
CGAffineTransform CGAffineTransformMakeShear(CGFloat x, CGFloat y){
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform.c = -x;
    transform.b = y;
    return transform;
}

@end
