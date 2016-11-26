//
//  ViewController.m
//  TextKitDemo
//
//  Created by ShenYj on 2016/11/25.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "ViewController.h"
#import "JSTextLabel.h"

@interface ViewController ()

@property (nonatomic,strong) JSTextLabel *textLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.textLabel];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (JSTextLabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[JSTextLabel alloc] init];
        _textLabel.frame = CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, 100);
        _textLabel.text = @"http://www.apple.com";
        _textLabel.backgroundColor = [UIColor orangeColor];
    }
    return _textLabel;
}

@end
