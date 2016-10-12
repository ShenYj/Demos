//
//  ViewController.m
//  StackView
//
//  Created by ShenYj on 16/8/2.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//


// 新建项目时选的iphone,手动改成Universal也无法实现分屏

#import "ViewController.h"
#import "JSButton.h"

@interface ViewController ()
// 大图
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIStackView *bottomStackView;

@end

@implementation ViewController

// 点击切换大图
- (IBAction)clickShowImageButton:(JSButton *)sender {
    
    NSString *imageName = [NSString stringWithFormat:@"skirts_0%zd",sender.tag];
    self.imageView.image = [UIImage imageNamed:imageName];
    
    self.imageView.alpha = 0.5;
    [UIView animateWithDuration:0.3 animations:^{
        self.imageView.alpha = 1;
    }];
}

// 点击后将按钮改为竖向排列
- (IBAction)clickaddStarBtn:(id)sender {

    [UIView animateWithDuration:0.3 animations:^{
        
        self.bottomStackView.axis = UILayoutConstraintAxisVertical;
    }];

}
// 点击后将按钮改为横向排列
- (IBAction)clickBuyBtn:(id)sender {

    [UIView animateWithDuration:0.3 animations:^{
        
        self.bottomStackView.axis = UILayoutConstraintAxisHorizontal;
    }];
    
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
