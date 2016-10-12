//
//  ViewController.m
//  UIStackView演练
//
//  Created by ShenYj on 16/8/2.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// 星星所在的StackView
@property (weak, nonatomic) IBOutlet UIStackView *starsStackView;

@end

@implementation ViewController

// 添加星星
- (IBAction)clickAddStarButton:(id)sender {
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"star"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.starsStackView addArrangedSubview:imageView];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.starsStackView layoutIfNeeded];
    }];
    
    
    
}
// 移除星星
- (IBAction)clickRemoveStarButton:(id)sender {
    
    if (self.starsStackView.subviews.count > 0) {
        
        // removeArrangedSubview代表当前的StackView不再管理子视图的布局,并不是从视图中移除
        [self.starsStackView.subviews.lastObject removeFromSuperview];
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [self.starsStackView layoutIfNeeded];
        }];
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
