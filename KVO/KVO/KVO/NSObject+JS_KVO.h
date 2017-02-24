//
//  NSObject+JS_KVO.h
//  KVO
//
//  Created by ShenYj on 2017/2/24.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^JSObservingBlock)(id observedObject, NSString *observedKey, id oldValue, id newValue);

@interface NSObject (JS_KVO)

- (void)JS_addObserver:(NSObject *)observer
                forKey:(NSString *)key
             withBlock:(JSObservingBlock)block;

- (void)JS_removeObserver:(NSObject *)observer forKey:(NSString *)key;

@end
