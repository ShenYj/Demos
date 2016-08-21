//
//  ViewController.m
//  线程间通讯
//
//  Created by ShenYj on 16/8/21.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController{
    
    // 图片框
    UIImageView *_imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 图片框初始化
    _imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 下载图片异步执行
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://m.818today.com/imgsy/image/2016/0113/6358830376853382456131864.jpg"]];
        UIImage *downImage = [UIImage imageWithData:data];
        
        // 刷新UI(通过主队列任务在主线程执行的特性,实现GCD子线程回归主线程执行任务)
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _imageView.image = downImage;
        });
        
    });
    
}

@end
