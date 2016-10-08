//
//  DetailViewController.m
//  UIView转场动画
//
//  Created by ShenYj on 2016/10/8.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic) UIImageView *imageView;
@property (nonatomic,assign) NSInteger index;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)swipeGesture:(UISwipeGestureRecognizer *)gesture {
    
    
    UIViewAnimationOptions animationOptions;
    
    if (gesture.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        self.index++;
        animationOptions = UIViewAnimationOptionTransitionFlipFromRight;
        
    } else if (gesture.direction == UISwipeGestureRecognizerDirectionRight) {
        
        self.index--;
        animationOptions = UIViewAnimationOptionTransitionFlipFromLeft;
    }
    
    // 循环图片
    if (self.index > 5) {
        
        self.index = 1;
        
    } else if (self.index < 1) {
        
        self.index = 5;
        
    }
    
    [UIView transitionWithView:self.imageView duration:2 options:animationOptions animations:nil completion:nil];
    
    // 拼接图片名
    NSString *imageName = [NSString stringWithFormat:@"%zd",self.index];
    self.imageView.image = [UIImage imageNamed:imageName];
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}
- (UIImageView *)imageView {
    
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor redColor];
        _imageView.userInteractionEnabled = YES;
        _imageView.image = [UIImage imageNamed:@"1"];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    self.index = 1;
    
    self.imageView.frame = CGRectMake(50, 100, [UIScreen mainScreen].bounds.size.width - 100, [UIScreen mainScreen].bounds.size.height - 150);
    [self.view addSubview:self.imageView];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.imageView addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.imageView addGestureRecognizer:swipeRight];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
