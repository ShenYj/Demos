//
//  ViewController.m
//  DynamicType
//
//  Created by ShenYj on 2017/1/12.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *demoLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 1. 设置字体大小
    self.demoLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    // 2. 允许调整
    self.demoLabel.adjustsFontForContentSizeCategory = YES;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
