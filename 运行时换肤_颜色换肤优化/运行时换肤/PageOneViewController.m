//
//  PageOneViewController.m
//  运行时换肤
//
//  Created by ShenYj on 16/7/17.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "PageOneViewController.h"
#import "UIImage+JSSkin.h"

@interface PageOneViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nightLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView_1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_2;
@property (weak, nonatomic) IBOutlet UISwitch *nightModeSwitch;

@end


@implementation PageOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取当前皮肤模式,同步Switch状态
    self.nightModeSwitch.on = [UIImage isNight];
    // 设置图片
    self.imageView_1.image = [UIImage imageNamed:@"baby"];
    self.imageView_2.image = [UIImage imageNamed:@"girl"];
    self.view.backgroundColor = [UIImage loadColorWithKey:@"one_view_bg"];
    self.nightLabel.textColor = [UIImage loadColorWithKey:@"vc_label_text"];
}

// Switch开关点击事件
- (IBAction)nightModeSwitchClick:(UISwitch *)sender {
    
    // 本地化存储(偏好设置)
    [UIImage saveSkinModeWithNight:sender.isOn];
    
    // 设置图片
    self.imageView_1.image = [UIImage imageNamed:@"baby"];
    self.imageView_2.image = [UIImage imageNamed:@"girl"];
    self.view.backgroundColor = [UIImage loadColorWithKey:@"one_view_bg"];
    self.nightLabel.textColor = [UIImage loadColorWithKey:@"vc_label_text"];
}

@end
