//
//  ViewController.m
//  sublayerTransform
//
//  Created by ShenYj on 2017/2/11.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *leftView;
@property (weak, nonatomic) IBOutlet UIImageView *rightView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = - 1.0 / 500.0;
    self.containerView.layer.sublayerTransform = perspective;
    //rotate layerView1 by 45 degrees along the Y axis
    CATransform3D transform1 = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    self.leftView.layer.transform = transform1;
    // 取消背面的绘制
    //self.leftView.layer.doubleSided = NO;
    
    //rotate layerView2 by 45 degrees along the Y axis
    CATransform3D transform2 = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
    self.rightView.layer.transform = transform2;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
