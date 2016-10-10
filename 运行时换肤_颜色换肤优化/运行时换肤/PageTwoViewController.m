//
//  PageTwoViewController.m
//  运行时换肤
//
//  Created by ShenYj on 16/7/17.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "PageTwoViewController.h"
#import "UIImage+JSSkin.h"

@interface PageTwoViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView_3;

@end

@implementation PageTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 设置图片
    self.imageView_3.image = [UIImage imageNamed:@"girl"];
    self.view.backgroundColor = [UIImage loadColorWithKey:@"vc_view_bg"];
}

@end
