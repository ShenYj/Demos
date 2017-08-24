//
//  ViewController.m
//  ProgressAlert
//
//  Created by ecg on 2017/8/24.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import "ViewController.h"
#import "JSProgressAlert.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    JSProgressAlert *alert = [JSProgressAlert alertControllerWithTitle: @"提示"
                                                               message: nil
                                                        preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
