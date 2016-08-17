//
//  JSNavigationController.m
//  HeaderViewScaleByDragging
//
//  Created by ShenYj on 16/8/16.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSNavigationController.h"

@implementation JSNavigationController


#pragma mark -- push隐藏导航栏

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    
    self.navigationBarHidden = YES;
    
}



@end
