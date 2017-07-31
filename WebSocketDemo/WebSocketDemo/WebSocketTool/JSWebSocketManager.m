//
//  JSWebSocketManager.m
//  WebSocketDemo
//
//  Created by ecg on 2017/7/31.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import "JSWebSocketManager.h"

#define WebSocketRequestUrlStringDeveloper @"ws://221.216.94.95:8081/runtime.server/rt.ws" //测试

static id _instanceType = nil;

@implementation JSWebSocketManager

+ (instancetype)sharedWebSocketManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instanceType = [[self alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:WebSocketRequestUrlStringDeveloper]]];
    });
    return _instanceType;
}

@end
