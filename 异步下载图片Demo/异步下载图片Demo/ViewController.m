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
//    [self downLoadImage];  主线程
//    [NSThread detachNewThreadSelector:@selector(downLoadImageBySubThread) toTarget:self withObject:nil];// 子线程下载设置图片
    [NSThread detachNewThreadSelector:@selector(downLoadImageBySubThreadAndBackMainThreadToUpdateUI) toTarget:self withObject:nil];// 子线程下载图片后,回到主线程刷新UI
}

// 子线程下载,回到主线程来刷新UI
- (void)downLoadImageBySubThreadAndBackMainThreadToUpdateUI{
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://m.818today.com/imgsy/image/2016/0215/6359115615139200378199199.jpg"]];
    UIImage *image = [UIImage imageWithData:data];
    
    NSLog(@"%@",[NSThread currentThread]);
    
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:NO];
}

- (void)updateUI:(UIImage *)image{
    
    NSLog(@"%@",[NSThread currentThread]);
    self.imageView.image = image;
}

// 子线程下载
- (void)downLoadImageBySubThread{
    
    
    NSLog(@"%@",[NSThread currentThread]);
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://m.818today.com/imgsy/image/2016/0215/6359115615139200378199199.jpg"]];
    UIImage *image = [UIImage imageWithData:data];
    self.imageView.image = image;
}

// 主线程下载
- (void)downLoadImage{
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://m.818today.com/imgsy/image/2016/0215/6359115615139200378199199.jpg"]];
    UIImage *image = [UIImage imageWithData:data];
    self.imageView.image = image;
}


@end
