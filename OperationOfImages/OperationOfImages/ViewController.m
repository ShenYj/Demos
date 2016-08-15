//
//  ViewController.m
//  OperationOfImages
//
//  Created by ShenYj on 16/8/15.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Extention.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];

    // 方式一:  设置圆角图片
    UIImage *image = [UIImage imageNamed:@"路飞.jpg"];
    imageView.image = [UIImage js_imageWithOriginalImage:[image js_imageWithSize:CGSizeMake(200, 200)]];

    // 方式二:
    UIImage *originalImage = [UIImage imageNamed:@"路飞.jpg"];
//    UIImage *resizedImage = [originalImage js_cornerImageWithSize:CGSizeMake(200, 200)];
//    UIImage *resizedImage = [originalImage js_cornerImageWithSize:CGSizeMake(200, 200) fillClolor:[UIColor whiteColor]];
    [originalImage js_cornerImageWithSize:CGSizeMake(200, 200) fillClolor:[UIColor whiteColor] completion:^(UIImage *img) {
        
        imageView.image = img;
    }];
}


- (void)setImageWithCustomSize{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    
    // 方式一:  直接按照ImageView的尺寸来设置图片
    // 图片的真实尺寸:  640 × 480 pixels
    imageView.image = [UIImage imageNamed:@"路飞.jpg"];
    
    // 方式二:  将图片尺寸处理后,得到与UIImageView一致的尺寸后再来设置
    UIImage *image = [UIImage imageNamed:@"路飞.jpg"] ;
    imageView.image = [image js_imageWithSize:CGSizeMake(200, 200)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
