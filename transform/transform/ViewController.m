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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [UIView animateWithDuration:3 animations:^{
//        self.redView.transform = CGAffineTransformRotate(self.redView.transform, M_PI_4);
//        self.redView.transform = CGAffineTransformTranslate(self.redView.transform, 100, 100);
        
        // 混合变换
        CGAffineTransform transForm1 = CGAffineTransformRotate(self.redView.transform, M_PI_4);
        CGAffineTransform transFrom2 = CGAffineTransformTranslate(self.redView.transform, 100, 100);
        CGAffineTransform transForm = CGAffineTransformConcat(transForm1, transFrom2);
        self.redView.transform = transForm;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
