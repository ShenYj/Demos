//
//  ViewController.m
//  ImageScaleDemo
//
//  Created by ShenYj on 2017/1/6.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+JSExtension.h"

@interface ViewController ()

@property (nonatomic) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    UIView *baseImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    baseImageView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:baseImageView];
    [self.view addSubview:self.imageView];
    __weak typeof(self) weakSelf = self;
    
    [[UIImage imageNamed:@"111.jpg"] js_ImageWithSize:CGSizeMake(40, 40) completion:^(UIImage *img) {
        weakSelf.imageView.image = img;
    }];
    
}


- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        //_imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"111.jpg"]];
        //[_imageView sizeToFit];
    }
    return _imageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
