//
//  JSHomeViewController.m
//  iPhoneXAdapterDemo
//
//  Created by ecg on 2017/11/10.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSHomeViewController.h"

@interface JSHomeViewController ()

@property (nonatomic,strong) UIView *container_View;

@end

@implementation JSHomeViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.container_View.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview: self.container_View];
    
    if (@available(iOS 11.0, *)) {
        
        NSLog(@"  self.view.safeAreaLayoutGuide.layoutFrame: %@",NSStringFromCGRect(self.view.safeAreaLayoutGuide.layoutFrame));
        NSLog(@"  self.view.safeAreaInsets             : %@",NSStringFromUIEdgeInsets(self.view.safeAreaInsets));
        NSLog(@"  self.additionalSafeAreaInsets        : %@",NSStringFromUIEdgeInsets(self.additionalSafeAreaInsets));
        NSLog(@"  self.additionalSafeAreaInsets.top    : %f",self.additionalSafeAreaInsets.top);
        NSLog(@"  self.additionalSafeAreaInsets.bottom : %f",self.additionalSafeAreaInsets.bottom);
        NSLog(@"  self.additionalSafeAreaInsets.left   : %f",self.additionalSafeAreaInsets.left);
        NSLog(@"  self.additionalSafeAreaInsets.right  : %f",self.additionalSafeAreaInsets.right);
    } else {
        
    }
    
    NSLog(@"  self.navigationController.topLayoutGuide.length           :  --> %f",self.navigationController.topLayoutGuide.length);
    NSLog(@"  self.navigationController.bottomLayoutGuide.length        :  --> %f",self.navigationController.bottomLayoutGuide.length);
    NSLog(@"  self.navigationController.navigationBar.frame.size.height :  --> %f",self.navigationController.navigationBar.frame.size.height);
    
    /***
     
     1. 竖屏
     1.1 iPhone 6s plus:
     self.navigationController.topLayoutGuide.length:                --> 20.000000
     self.navigationController.bottomLayoutGuide.length:             --> 49.000000
     self.navigationController.navigationBar.frame.size.height:      --> 44.000000
     
     1.2 iPhone X:
     self.navigationController.topLayoutGuide.length:                --> 44.000000
     self.navigationController.bottomLayoutGuide.length:             --> 83.000000
     self.navigationController.navigationBar.frame.size.height:      --> 44.000000
     
     2. 横屏
     2.1 iPhone 6s plus:
     self.navigationController.topLayoutGuide.length:                --> 0.000000
     self.navigationController.bottomLayoutGuide.length:             --> 49.000000
     self.navigationController.navigationBar.frame.size.height:      --> 44.000000
     
     2.2 iPhone X:
     self.navigationController.topLayoutGuide.length:                --> 0.000000
     self.navigationController.bottomLayoutGuide.length:             --> 53.000000
     self.navigationController.navigationBar.frame.size.height:      --> 32.000000
     ***/
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem: self.container_View
                                                                     attribute: NSLayoutAttributeTop
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: self.view
                                                                     attribute: NSLayoutAttributeTop
                                                                    multiplier: 1
                                                                      constant: self.navigationController.topLayoutGuide.length + self.navigationController.navigationBar.frame.size.height];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem: self.container_View
                                                                       attribute: NSLayoutAttributeWidth
                                                                       relatedBy: NSLayoutRelationEqual
                                                                          toItem: nil
                                                                       attribute: NSLayoutAttributeNotAnAttribute
                                                                      multiplier: 1
                                                                        constant: 100];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem: self.container_View
                                                                        attribute: NSLayoutAttributeBottom
                                                                        relatedBy: NSLayoutRelationEqual
                                                                           toItem: self.view
                                                                        attribute: NSLayoutAttributeBottom
                                                                       multiplier: 1
                                                                         constant: -self.navigationController.bottomLayoutGuide.length];
    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem: self.container_View
                                                                         attribute: NSLayoutAttributeCenterX
                                                                         relatedBy: NSLayoutRelationEqual
                                                                            toItem: self.view
                                                                         attribute: NSLayoutAttributeCenterX
                                                                        multiplier: 1
                                                                          constant: 0];
    [self.view addConstraints: @[ topConstraint, widthConstraint, bottomConstraint, centerXConstraint]];
    
    
}



#pragma mark - lazy

- (UIView *)container_View {
    if (!_container_View) {
        _container_View = [[UIView alloc] init];
        _container_View.backgroundColor = [UIColor greenColor];
    }
    return _container_View;
}

@end
