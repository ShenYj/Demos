//
//  ViewController.m
//  01-Core Data
//
//  Created by ShenYj on 16/7/25.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Person.h"

@interface ViewController ()

@property (nonatomic,strong) AppDelegate *appDelegate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self insertData];
    [self insertDataWithSubclass];
    
    // 打印沙盒路径
    NSLog(@"%@",[self.appDelegate applicationDocumentsDirectory]);
    
}

// 插入数据
- (void)insertData{
    
    // 设置实体   entityForName(相当于表名)
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.appDelegate.managedObjectContext];
    
    // 创建并且插入的数据   对应数据库中的一条记录  基类NSManagerObject
    NSManagedObject *person = [[NSManagedObject alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.appDelegate.managedObjectContext];
    
    // 插入数据  如果需要插入的数据上下文对象还不确定,上面设置实体,插入数据时,上下文可以传nil,再通过下面的方法分开使用
    // self.appDelegate.managedObjectContext insertObject:<#(nonnull NSManagedObject *)#>
    
    // 设置数据
    [person setValue:@"laowang" forKey:@"name"];
    [person setValue:@18 forKey:@"age"];
    [person setValue:@178.5 forKey:@"height"];
    
    // 如果字段比较多,通过KVC的方式来设置数据显然是不方便的
    // 直接
    
    // 保存上下文 保存后才会和数据库进行同步
    [self.appDelegate saveContext];
    
}

// 通过数据模型子类
- (void)insertDataWithSubclass{
    
    // 设置实体 entityForName (相当于表名)
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.appDelegate.managedObjectContext];
    // 创建并且插入的数据
    Person *person = [[Person alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.appDelegate.managedObjectContext];
    
    // 设置数据
    person.name = @"laozhang";
    person.age = @30;
    person.height = @158.2;
    
    // 保存上下文
    [self.appDelegate saveContext];
    
}

- (AppDelegate *)appDelegate{
    
    //    ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectModel
    if (_appDelegate == nil) {
        
        _appDelegate = [UIApplication sharedApplication].delegate;
    }
    return _appDelegate;
}

@end
