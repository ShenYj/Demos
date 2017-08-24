//
//  ViewController.m
//  AlertController
//
//  Created by ecg on 2017/8/23.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import "ViewController.h"
#import "JSAlertController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    NSString *msg = @"最新版本:1.1.4\n版本大小:151.89KB\n更新内容:1.修改bug";
    JSAlertController *alertController = [JSAlertController alertControllerWithTitle:@"发现设备新版本"
                                                                            message:msg
                                                                     preferredStyle:UIAlertControllerStyleAlert];
//    alertController.view.backgroundColor = [UIColor redColor];
//    UIView *subView1 = alertController.view.subviews[0];
//    UIView *subView2 = subView1.subviews[0];
//    UIView *subView3 = subView2.subviews[0];
//    UIView *subView4 = subView3.subviews[0];
//    UIView *subView5 = subView4.subviews[0];
//    NSLog(@"%@",subView5.subviews);
//    //取title和message：
//    UILabel *title = subView5.subviews[0];
//    UILabel *message = subView5.subviews[1];
//    message.textAlignment = NSTextAlignmentLeft;
//    alertController.messgeLabel.textAlignment = NSTextAlignmentLeft;
    
    UIAlertAction *close = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:close];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
