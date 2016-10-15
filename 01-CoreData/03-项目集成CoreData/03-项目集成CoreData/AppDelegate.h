//
//  AppDelegate.h
//  03-项目集成CoreData
//
//  Created by ShenYj on 16/7/25.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
// 数据上下文  直接负责数据的增删改查
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
// 数据模型 对应的数据模型文件(.xcdatamodeld)
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
// 持久化存储协调器
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

// 保存上下文   增删改查后,必须保存上下文,持久化协调器才会将数据和数据库同步
- (void)saveContext;
// 沙盒Documents路径    CoreData生成的数据库默认就在Documents中
- (NSURL *)applicationDocumentsDirectory;

@end

