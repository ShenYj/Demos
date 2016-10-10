//
//  ViewController.m
//  基础换肤
//
//  Created by ShenYj on 16/7/17.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+JSImage.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView_1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_2;
@property (weak, nonatomic) IBOutlet UISwitch *nightSwitch;

@end

@implementation ViewController

// 声明全局变量
//bool isNight;

// 切换夜间模式
- (IBAction)clickNightSwitch:(UISwitch *)sender {
    
    // 保存皮肤
    [UIImage saveSkinWithNight:sender.isOn];
    // 赋值  通过封装的方法已经将标识传递,所以不再需要使用全局变量了
//    isNight = sender.isOn;
    
//    if (sender.isOn) { // switch开启,代表夜间模式
//        self.imageView_1.image = [UIImage imageNamed:@"baby_night"];
//        self.imageView_2.image = [UIImage imageNamed:@"girl_night"];
//    } else {
//        self.imageView_1.image = [UIImage imageNamed:@"baby"];
//        self.imageView_2.image = [UIImage imageNamed:@"girl"];
//    }
    
    // 因为判断已经放在了UIImage分类中,所以这里不再需要判断
    self.imageView_1.image = [UIImage JSImageNamed:@"baby"];
    self.imageView_2.image = [UIImage JSImageNamed:@"girl"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 默认关闭  日间模式
    self.nightSwitch.on = [UIImage isNight];
    
//    self.imageView_1.image = [UIImage imageNamed:@"baby"];
//    self.imageView_2.image = [UIImage imageNamed:@"girl"];
    
    self.imageView_1.image = [UIImage JSImageNamed:@"baby"];
    self.imageView_2.image = [UIImage JSImageNamed:@"girl"];
    
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
