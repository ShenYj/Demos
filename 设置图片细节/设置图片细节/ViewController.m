//
//  ViewController.m
//  设置图片细节
//
//  Created by ShenYj on 16/8/11.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    
    // 设置图片 1:  直接使用项目bundle路径中图片资源(.png)
    // imageView.image = [UIImage imageNamed:@"MJ"];
    
    // 设置图片 2:  直接使用项目bundle路径中图片资源(.jpg)  --> 需要补充后缀,否则图片不被显示
     imageView.image = [UIImage imageNamed:@"路飞.jpg"];
    
    // 设置图片 3: 使用Assets.xasssets中的图片资源(.png)
    // imageView.image = [UIImage imageNamed:@"艾尼路"];
    
    // 设置图片 4: 使用Assets.xasssets中的图片资源(.jpg)
    // imageView.image = [UIImage imageNamed:@"佩恩"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
