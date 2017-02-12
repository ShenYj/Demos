//
//  ViewController.m
//  自定义Label
//
//  Created by ShenYj on 2017/2/12.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "ViewController.h"
#import "JSLayerLabel.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet JSLayerLabel *layerLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.layerLabel.text = @"在这个简单的例子中，我们只是实现了UILabel的一部分风格和布局属性，不过稍微再改进一下我们就可以创建一个支持UILabel所有功能甚至更多功能的LayerLabel类";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
