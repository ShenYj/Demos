//
//  JSCoreDataManagerTool.m
//  JSCoreDataManagerTool
//
//  Created by ShenYj on 2016/10/17.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "JSCoreDataManagerTool.h"

static NSString * const kDataBaseName = @"Model.sqlite";    // 设置数据库文件路径
static NSString * const kXCDataModelName = @"Model";        // 设置模型文件路径
static JSCoreDataManagerTool *_instanceType = nil;

@implementation JSCoreDataManagerTool

#pragma mark
#pragma mark - 获取单例
+ (instancetype)sharedManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instanceType = [[self alloc] init];
    });
    return _instanceType;
}


#pragma mark
#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

// 获取沙盒路径 Document
- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "itcast._1_CoreData_____" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

// 获取数据模型文件
- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
#pragma mark 设置模型文件路径
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:kXCDataModelName withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// 获取持久化协调器
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store 生成持久化协调器&数据库
    // 创建持久化协调器  设置数据模型文件
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
#pragma mark 设置数据库文件路径
    // 设置数据库路径
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:kDataBaseName];
    
    // 打印错误
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    
    // 持久化协调器 设置持久化类型&配置&数据库路径
    
    /*      数据迁移选项
     
    COREDATA_EXTERN NSString * const NSIgnorePersistentStoreVersioningOption;
    COREDATA_EXTERN NSString * const NSMigratePersistentStoresAutomaticallyOption;
    COREDATA_EXTERN NSString * const NSInferMappingModelAutomaticallyOption;
     
         NSIgnorePersistentStoreVersioningOption        忽略数据库版本(不使用数据迁移)
         NSMigratePersistentStoresAutomaticallyOption   自动进行数据迁移
         NSInferMappingModelAutomaticallyOption         自动生成一个映射模型(轻量级数据迁移使用自动生成即可)
     */
    
#pragma mark 轻量级数据迁移 (用途:增删字段、改表名、改字段名)
    /*
    NSDictionary *lightweightOptions = @{
                              NSMigratePersistentStoresAutomaticallyOption: @YES,
                              NSInferMappingModelAutomaticallyOption: @YES
                              };
     */
#pragma mark 自定义级数据迁移 ()
    /*
    NSDictionary *customOptions = @{
                              NSMigratePersistentStoresAutomaticallyOption: @YES,
                              NSInferMappingModelAutomaticallyOption: @NO
                              };
     */
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        // abort(); 中断应用并且显示控制台打印(展示崩溃原因),最早使用该方法来关闭应用,现在只用于调试,如果使用该方法,AppStore不会审核通过
    }
    
    return _persistentStoreCoordinator;
}

// 获取数据上下文
- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    // 获取持久化协调器
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    // 创建数据上下文
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    /*  并发类型(上下文操作在什么线程中执行)
         NSPrivateQueueConcurrencyType		= 0x01,  在异步线程中执行上下文操作
         NSMainQueueConcurrencyType			= 0x02   在主线程中执行上下文操作
     */
    
    // 数据上下文需要设置持久化协调器
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark
#pragma mark - Core Data Saving support

// 错误打印&保存上下文
- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        
        // 错误打印 如果上下文发生变化&上下文保存失败
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            // abort();
        }
    }
}

@end
