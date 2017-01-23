//
//  ViewController.m
//  StackViewDemo2
//
//  Created by ShenYj on 2017/1/23.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIStackView *starStackView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)ClickAddButton:(UIButton *)sender {
    UIImage *image = [UIImage imageNamed:@"star"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.starStackView addArrangedSubview:imageView];
    [UIView animateWithDuration:0.25 animations:^{
        [self.starStackView layoutIfNeeded];
    }];
}

- (IBAction)clickRemoveButton:(UIButton *)sender {
    if (self.starStackView.subviews.count > 0) {
        UIImageView *imageView = self.starStackView.subviews.lastObject;
        [self.starStackView removeArrangedSubview:imageView];
        [imageView removeFromSuperview];
        [UIView animateWithDuration:0.25 animations:^{
            [self.starStackView layoutIfNeeded];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
