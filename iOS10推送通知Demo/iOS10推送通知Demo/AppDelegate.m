//
//  AppDelegate.m
//  iOS10推送通知Demo
//
//  Created by ShenYj on 2016/12/26.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>



@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 1.1 请求通知授权
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionSound | UNAuthorizationOptionBadge | UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            NSLog(@"授权成功");
        }
        if (error) {
            
            NSLog(@"授权失败:%@",error);
        }
    }];
    
    
    // 1.2 使用付费的开发者账号
    // 1.3 开启Push Notifications功能 --> [Advanced App Capabilities](https://developer.apple.com/support/app-capabilities/)
    
    // 2. 注册通知
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    // 3. 设置代理 --> 监听远程通知推送的内容,进一步处理
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    
    return YES;
}

/** 1.4 注册远程通知获取DeviceToken,将DeviceToken发送给服务器 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"%@",deviceToken);
}

/** 3.2 处理通知 ---> 在前台运行时的情况 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    
    [self showLabelWithUserInfo:notification.request.content.userInfo color:[UIColor purpleColor]];
    // 在前台运行时收到通知的呈现效果
    completionHandler(UNNotificationPresentationOptionBadge |
                      UNNotificationPresentationOptionSound |
                      UNNotificationPresentationOptionAlert
                      );
}

/** 3.3 处理通知 ---> 在后台运行时或已退出的情况 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler {
    
    [self showLabelWithUserInfo:response.notification.request.content.userInfo color:[UIColor redColor]];
    
    completionHandler();
}

/** 4 静默通知: 如果是以前的旧框架, 此方法对 前台/后台/退出/静默推送都可以处理 ,在iOS 10下,值处理静默通知 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler {
    /*
     静默推送: iOS7以后出现, 不会出现提醒及声音.
     要求:
         推送的payload中不能包含alert及sound字段
         需要添加content-available字段, 并设置值为1
         例如: {"aps":{"content-available":"1"},"PageKey”":"2"}
     */
    [self showLabelWithUserInfo:userInfo color:[UIColor greenColor]];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

/** 接收通知自定义处理的操作demo */
- (void)showLabelWithUserInfo:(NSDictionary *)userInfo color:(UIColor *)color {
    UILabel *label = [UILabel new];
    label.backgroundColor = color;
    label.frame = CGRectMake(0, 250, [UIScreen mainScreen].bounds.size.width, 300);
    label.text = userInfo.description;
    label.numberOfLines = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:label];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
