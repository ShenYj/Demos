//
//  ViewController.m
//  CALayer的mask属性
//
//  Created by ShenYj on 2017/1/23.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) CALayer *maskLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IMG_3946"]];
    self.imageView.frame = CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width - 40, 300);
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.layer.borderWidth = 1.0;
    self.imageView.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:self.imageView];
    
    self.imageView.layer.shadowOpacity = 0.5;
    self.imageView.layer.shadowOffset = CGSizeMake(-10, 10);
    self.imageView.layer.shadowRadius = 5.0;
    
    //self.imageView.layer.masksToBounds = YES; 会裁切子视图和阴影
    
    /*
    self.maskLayer = [CALayer layer];
    self.maskLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"arrow"].CGImage);
    self.maskLayer.frame = self.imageView.bounds;
    
    self.imageView.layer.mask = self.maskLayer;
     */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
