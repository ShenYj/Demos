//
//  ViewController.m
//  代码实现Popover
//
//  Created by ShenYj on 16/9/22.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIPopoverPresentationControllerDelegate>

@property (nonatomic,strong) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.button];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Item" style:UIBarButtonItemStylePlain target:self action:@selector(clickButton:)];
    
}

- (void)clickButton:(id)sender {
    
    // 创建一个目标控制
    UIViewController *destination = [[UIViewController alloc] init];
    destination.view.backgroundColor = [UIColor greenColor];
    
    // 设置Popover ContentSize
    destination.preferredContentSize = CGSizeMake(120, 200);
    
    // 设置Modal类型为Popover
    destination.modalPresentationStyle = UIModalPresentationPopover;
    
    // 获取Popover对象
    UIPopoverPresentationController *popover = destination.popoverPresentationController;
    
    // 设置代理,取消自适应
    popover.delegate = self;
    
    // 来源视图
    if ([sender isKindOfClass:[UIButton class]]) {
        
        UIButton *button = (UIButton *)sender;
        // 设置来源视图:在StoryBoard下,根据连线会自动设置来源视图或BarButtonItem,纯代码下需要手动设置,否则运行会直接崩溃
        popover.sourceView = button;
        // 设置参考点
        popover.sourceRect = button.bounds;
        
    } else {
        
        // BarButtonItem
        popover.barButtonItem = sender;
        
    }
    
    // Modal展示(Popover)
    [self presentViewController:destination animated:YES completion:nil];
    
}

#pragma mark - UIAdaptivePresentationControllerDelegate
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    
    return UIModalPresentationNone;
}


#pragma mark - lazy
- (UIButton *)button {
    
    if (_button == nil) {
        _button = [[UIButton alloc] initWithFrame:CGRectMake(80, 80, 100, 40)];
        _button.layer.borderColor = [UIColor purpleColor].CGColor;
        _button.layer.borderWidth = 2;
        _button.backgroundColor = [UIColor orangeColor];
        _button.titleLabel.font = [UIFont systemFontOfSize:16];
        [_button setTitle:@"button" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _button;
}

@end
