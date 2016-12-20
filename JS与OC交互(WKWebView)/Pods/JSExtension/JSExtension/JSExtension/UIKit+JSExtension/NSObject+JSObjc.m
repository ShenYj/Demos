//
//  NSObject+JSObjc.m
//  Demos
//
//  Created by ShenYj on 16/9/3.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "NSObject+JSObjc.h"
#import <objc/runtime.h>

@implementation NSObject (JSObjc)


+ (NSArray *)js_objProperties{
    
    /*
     class_copyIvarList(__unsafe_unretained Class cls, unsigned int *outCount)       成员变量
     class_copyMethodList(__unsafe_unretained Class cls, unsigned int *outCount)     方法
     class_copyPropertyList(__unsafe_unretained Class cls, unsigned int *outCount)   属性
     class_copyProtocolList(__unsafe_unretained Class cls, unsigned int *outCount)   协议
     */
    
    /*      调用运行时方法,取得类的属性列表
     
     返回值 : 所有属性的数组 (是一个C数组指针:C语言中数组的名字就是首元素的地址)
     参数 1 :  要获取的类
     参数 2 :  类属性的个数指针
     */
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    
    // 用来存放所有属性的数组
    NSMutableArray *mArr = [NSMutableArray array];
    
    // 遍历所有属性
    for (unsigned int i = 0; i < count; i ++) {
        
        // 1. 从数组中取得所有属性
        objc_property_t property = propertyList[i];
        
        const char *cName = property_getName(property);
        
        NSString *propertyName = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        
        [mArr addObject:propertyName];
        
    }
    
    // C语言中 retain/create/copy 都需要release, 可以option+click方法名,通过API描述中找到释放方法
    // 例如这里的提示: You must free the array with free().
    free(propertyList);
    
    return mArr.copy;
}



/**
 *  打印类的所有属性
 *
 *  @param className 类名
 */
+ (void)js_logPrivatePropertiesWithClass:(NSString *)className{
    
    unsigned int count = 0;
    
    objc_property_t *properties = class_copyPropertyList([NSClassFromString(className) class], &count);
    
    for (int i=0; i<count; i++) {
        
        objc_property_t pty = properties[i];
        
        //获得所有的属性
        const char *cname = property_getName(pty);
        
        NSLog(@"%@",[[NSString alloc] initWithCString:cname encoding:NSUTF8StringEncoding]);
    }
    
    free(properties);
    
}

/**
 *  打印类的所有成员变量
 *
 *  @param className 类名
 */
+ (void)js_logPrivateIvarsWithClass:(NSString *)className{
    
    unsigned int count = 0; //这个是所有属性的个数
    
    //所有属性的数组 ,数组 char[] char *
    Ivar *ivars = class_copyIvarList([NSClassFromString(className) class], &count);
    
    for (int i=0; i<count; i++) {
        
        Ivar ivar = ivars[i];//获取到每一个属性
        
        //获取所有私有属性
        const char *cname = ivar_getName(ivar);//C语言的字符串
        
        NSLog(@"%@",[[NSString alloc] initWithCString:cname encoding:NSUTF8StringEncoding]);
    }
    
    free(ivars);
}

@end
