//
//  ViewController.m
//  线程间通讯
//
//  Created by ShenYj on 16/8/22.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    // 图片框
    UIImageView *_imageView;
    // 队列
    NSOperationQueue *_queue;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    // 图片框初始化
    _imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _imageView.contentMode = UIViewContentModeCenter;
    [self.view addSubview:_imageView];
    
    // 队列初始化
    _queue = [[NSOperationQueue alloc] init];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 触摸屏幕时下载图片
    [self downloadImg];
}

// 下载图片
- (void)downloadImg{
    
    // 异步下载图片
    [_queue addOperationWithBlock:^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://m.818today.com/imgsy/image/2016/0215/6359115615139200378199199.jpg"]];
        UIImage *image = [UIImage imageWithData:data];
        
        NSLog(@"%@",[NSThread currentThread]);
        
        // 返回主线程刷新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            _imageView.image = image;
            NSLog(@"%@",[NSThread currentThread]);
            
        }];
    }];
    
}

@end
