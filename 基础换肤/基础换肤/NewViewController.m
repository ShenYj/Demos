//
//  NewViewController.m
//  基础换肤
//
//  Created by ShenYj on 16/7/17.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "NewViewController.h"
#import "UIImage+JSImage.h"

@interface NewViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageVIew_3;

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.imageVIew_3.image = [UIImage imageNamed:@"girl"];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.imageVIew_3.image = [UIImage JSImageNamed:@"girl"];
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
