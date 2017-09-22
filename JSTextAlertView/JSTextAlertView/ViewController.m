//
//  ViewController.m
//  JSTextAlertView
//
//  Created by ecg on 2017/9/21.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+Extend.h"
#import "JSTextAlertView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    JSTextAlertView *alert = [[JSTextAlertView alloc] initWithTitle:@"提示"
                                                            message:@"切换城市失败，是否重试？"
                                                      constantWidth:290];
    JSTextAlertButton *cancelButton = [JSTextAlertButton buttonWithTitle:@"取消" handler:NULL];
    JSTextAlertButton *okButton = [JSTextAlertButton buttonWithTitle:@"确定" handler:^(JSTextAlertButton * _Nonnull button) {
        //[self.zh_popupController dismiss];
    }];
//    cancelButton.lineColor = [UIColor colorWithHexString:@"#FC7541"];
//    okButton.lineColor = cancelButton.lineColor;
    [cancelButton setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [okButton setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    cancelButton.edgeInsets = UIEdgeInsetsMake(15, 0, 0, 0);
    [alert adjoinWithLeftAction:cancelButton rightAction:okButton];
    
    [okButton setButtonClickedBlock:^(JSTextAlertButton * _Nonnull alertButton) {
       
        [alert hiddenCurrentView];
    }];
    [alert showComposeViewWithCompeletionHandler:^(NSString * _Nonnull clsName) {
       
        NSLog(@"%@",clsName);
    }];
    
}


@end
