//
//  JSWebSocketManager.h
//  WebSocketDemo
//
//  Created by ecg on 2017/7/31.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SocketRocket.h>


@interface JSWebSocketManager : SRWebSocket

/*!
 *  @metohd sharedWebSocketManager
 *
 *  @discussion             获取SRWebSocket单例
 */
+ (instancetype)sharedWebSocketManager;

@end
