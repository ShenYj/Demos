//
//  ViewController.m
//  ImageDemo
//
//  Created by ShenYj on 2016/11/30.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor greenColor];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.bounds = CGRectMake(0, 0, 200, 200);
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    UIImage *image = [UIImage imageNamed:@"v2_pullRefresh1"];
    CGRect rect = CGRectMake(0, 0, 200, 200);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 200), YES, 0.0);
//    [[UIColor blueColor] setFill];
//    UIRectFill(rect);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:100] addClip];
    [image drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    imageView.image = newImage;
    UIGraphicsEndImageContext();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
