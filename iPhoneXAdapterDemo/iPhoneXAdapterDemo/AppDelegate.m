//
//  AppDelegate.m
//  iPhoneXAdapterDemo
//
//  Created by ecg on 2017/11/10.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "AppDelegate.h"
#import "JSTsbBarController.h"
#import "JSHomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    JSTsbBarController *tabBar = [[JSTsbBarController alloc] init];
    self.window.rootViewController = tabBar;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
