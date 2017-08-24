//
//  JSAlertController.m
//  AlertController
//
//  Created by ecg on 2017/8/23.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import "JSAlertController.h"

@interface JSAlertController ()

@end

@implementation JSAlertController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getMessageLabelAndTitleLabel];
}

- (void)getMessageLabelAndTitleLabel
{
    UIView *subView1 = self.view.subviews[0];
    UIView *subView2 = subView1.subviews[0];
    UIView *subView3 = subView2.subviews[0];
    UIView *subView4 = subView3.subviews[0];
    UIView *subView5 = subView4.subviews[0];
    //NSLog(@"%@",subView5.subviews);
    //取title和message：
    self.titleLabel = subView5.subviews[0];
    self.messgeLabel = subView5.subviews[1];
    
    self.messgeLabel.textAlignment = NSTextAlignmentLeft;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
