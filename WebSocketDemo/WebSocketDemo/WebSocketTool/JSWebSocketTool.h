//
//  JSWebSocketTool.h
//  WebSocketDemo
//
//  Created by ecg on 2017/7/31.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface JSWebSocketTool : NSObject

/*!
 *  @metohd sharedWebSocketToolManager
 *
 *  @discussion             WebSocket工具单例
 */
+ (instancetype)sharedWebSocketToolManager;

/*!
 *  @metohd js_WebSocket_initialWebSocketService
 *
 *  @discussion             初始化 WebSocket
 */
- (instancetype)js_WebSocket_initialWebSocketService;

/*!
 *  @metohd js_WebSocket_open
 *
 *  @discussion             连接 WebSocket
 */
- (void)js_WebSocket_open;

/*!
 *  @metohd js_WebSocket_close
 *
 *  @discussion             断开 WebSocket
 */
- (void)js_WebSocket_close;

/*!
 *  @metohd js_WebSocket_sendData:
 *
 *  @param data             发送数据
 *
 *  @discussion             向服务器发送数据
 */
- (void)js_WebSocket_sendData:(id)data;

/*!
 *  @metohd js_WebSocket_reConnect:
 *
 *  @param handler          完成回调
 *
 *  @discussion             重连
 */
- (void)js_WebSocket_reConnect: (void(^)(BOOL result))handler;

@end
