//
//  JSWebSocketManager.h
//  WebSocketDemo
//
//  Created by ecg on 2017/7/31.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SocketRocket.h>

#define WebSocketRequestUrlStringDeveloper @"ws://221.216.94.95:8081/runtime.server/rt.ws" //测试

@interface JSWebSocketManager : SRWebSocket

/*!
 *  @metohd sharedWebSocketManager
 *
 *  @discussion             获取SRWebSocket单例
 */
+ (instancetype)sharedWebSocketManager NS_UNAVAILABLE;

@end
