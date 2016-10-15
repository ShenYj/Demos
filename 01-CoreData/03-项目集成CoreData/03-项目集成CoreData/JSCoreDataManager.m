//
//  JSCoreDataManager.m
//  03-项目集成CoreData
//
//  Created by ShenYj on 16/7/25.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSCoreDataManager.h"

static JSCoreDataManager *_instanceType = nil;

@implementation JSCoreDataManager

+ (instancetype)sharedCoreDataManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instanceType = [[JSCoreDataManager alloc]init];
    });
    return _instanceType;
}
#pragma mark - Core Data stack



/*      手动生成成员变量
    因为.h中声明的属性使用了readOnly修饰,相当于只声明了getter方法和同名带下划线的成员变量
    但这里同时重写了getter方法,系统就不会自动生成同名带下划线的成员变量,所以使用了@synthesize合成
 */
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

// 获取沙盒
- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "---ShenYJ---._1_Core_Data" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

// 获取数据模型文件
- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    // 设置数据模型文件的路径
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// 获取持久化协调器
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // 生成持久化协调器&数据库
    // 创建持久化协调器  需要设置数据模型文件
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    // 设置数据库路径  (自定义路径)
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"model.sqlite"];
    
    // 打印错误
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    // 持久化协调器  设置持久化类型
    
    /*
         NSSQLiteStoreType      数据库
         NSXMLStoreType         XML文件,相当于plist存储
         NSBinaryStoreType      二进制,相当于归档
         NSInMemoryStoreType    内存中,相当于缓存
         
         (所以我们一般只使用这种类型)
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
        // abort();
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
    // 创建数据上下文 : 并发类型
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    /**
            并发类型:  上下文操作在什么线程执行
     *      NSPrivateQueueConcurrencyType		= 0x01, 在异步线程中执行上细纹操作
            NSMainQueueConcurrencyType			= 0x02  在主线程中执行上下文操作
     */
    
    // 数据上下文 需要设置 持久化协调器
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
    // 实际上数据上下文保存数据后,数据库的存储操作都是由持久化协调器来完成
}

#pragma mark - Core Data Saving support

// 保存数据上下文
- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        
        // 错误打印&保存上下文  如果上下文发生变化&上下文保存失败 就执行下边的错误打印
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            
            /*
                可以中断应用并显示控制器打印(展示崩溃原因),最早使用该方法关闭应用,苹果为了统一操作的一致性,不再允许使用这种方式关闭应用(不允许上架)
                现在只用于调试
             */
            // abort();
        }
    }
}

@end
