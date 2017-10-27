//
//  OCSocketManager.h
//  SocketDemo
//
//  Created by ecg on 2017/10/20.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCSocketManager : NSObject <GCDAsyncUdpSocketDelegate>

+ (instancetype)sharedManager;

@end
