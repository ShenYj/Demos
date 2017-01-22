//
//  ViewController.m
//  StackView练习
//
//  Created by ShenYj on 2017/1/22.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "ViewController.h"
#import "ImageButton.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *centerImageView;

@end

@implementation ViewController


- (IBAction)ClickImageButton:(ImageButton *)sender {
    NSInteger tag = sender.tag;
    NSString *imageName = [NSString stringWithFormat:@"skirts_0%zd",tag];
    self.centerImageView.image = [UIImage imageNamed:imageName];
    self.centerImageView.alpha = 0.5;
    [UIView animateWithDuration:0.3 animations:^{
        self.centerImageView.alpha = 1.0;
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
