//
//  OCSocketManager.h
//  SocketDemo
//
//  Created by ecg on 2017/10/20.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaAsyncSocket/GCDAsyncSocket.h>         // TCP
#import <CocoaAsyncSocket/GCDAsyncUdpSocket.h>      // UDP

@interface OCSocketManager : NSObject <GCDAsyncUdpSocketDelegate>

+ (instancetype)sharedManager;

@end
