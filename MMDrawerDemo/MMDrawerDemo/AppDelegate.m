//
//  AppDelegate.m
//  MMDrawerDemo
//
//  Created by ShenYj on 2016/11/28.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "LeftVC.h"
#import "MMDrawerController.h"

@interface AppDelegate ()

@property(nonatomic ,strong)MMDrawerController *drawerController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self setRootVc];
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (void)setRootVc{
    
    LeftVC *leftVc = [[LeftVC alloc] init];
    
    ViewController *homeVc = [[ViewController alloc] init];
    
    UINavigationController *navH = [[UINavigationController alloc] initWithRootViewController:homeVc];
    
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:navH leftDrawerViewController:leftVc];
    
    self.drawerController.view.backgroundColor = [UIColor whiteColor];
    
    [self.drawerController setShowsShadow:YES];
    // 右控制器的初始宽度
    [self.drawerController setMaximumLeftDrawerWidth:200.0];
    // 打开手势操作区域
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    // 关闭手势操作区域
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    // 把对象作为根视图
    [self.window setRootViewController:self.drawerController];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
