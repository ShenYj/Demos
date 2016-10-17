//
//  JSCoreDataManagerTool.h
//  JSCoreDataManagerTool
//
//  Created by ShenYj on 2016/10/17.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface JSCoreDataManagerTool : NSObject

// 单例方法
+ (instancetype)sharedManager;

//数据上下文   直接负责数据的增删改查
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//数据模型    对应的数据模型文件
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//持久化协调器   用于设置和进行数据存储的
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//保存上下文   增删改查后必须保存上下文,持久化协调器才会将数据和数据库进行同步
- (void)saveContext;
//沙盒Documents路径  CoreData生成的数据库默认就在这个位置
- (NSURL *)applicationDocumentsDirectory;


@end
