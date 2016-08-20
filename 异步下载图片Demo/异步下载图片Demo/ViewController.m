//
//  ViewController.m
//  异步下载图片Demo
//
//  Created by ShenYj on 16/8/20.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// 图片框
@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.imageView];
    
    // 下载图片
    [self downLoadImage];
}


// 主线程下载
- (void)downLoadImage{
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://m.818today.com/imgsy/image/2016/0215/6359115615139200378199199.jpg"]];
    UIImage *image = [UIImage imageWithData:data];
    self.imageView.image = image;
}


@end
