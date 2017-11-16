//
//  ViewController.m
//  JS与OC交互(WKWebView)
//
//  Created by ShenYj on 2016/12/20.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "ViewController.h"
#import "JSWKWebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    JSWKWebViewController *webViewController = [[JSWKWebViewController alloc] init];
    [self.navigationController pushViewController:webViewController animated:YES];
}

@end
