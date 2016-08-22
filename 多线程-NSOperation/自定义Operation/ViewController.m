//
//  ViewController.m
//  自定义Operation
//
//  Created by ShenYj on 16/8/22.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"
#import "DownloadOperation.h"


@interface ViewController ()

@end

@implementation ViewController{
    
    NSOperationQueue *_queue;
    UIImageView *_imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _queue = [[NSOperationQueue alloc] init];
    _imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _imageView.contentMode = UIViewContentModeCenter;
    [self.view addSubview:_imageView];
    
    // 1.创建自定义的Operation对象 (下载图片操作)
    DownloadOperation *operation = [[DownloadOperation alloc] init];
    
    operation.urlString = @"http://t1.mmonly.cc/mmonly/2014/201407/129/7.jpg";
    [operation setCompleteHandler:^(UIImage *img) {
        
        // 更新UI
        _imageView.image = img;
    }];
    
    // 2.把操作添加到队列中
    [_queue addOperation:operation];
    
}


@end
