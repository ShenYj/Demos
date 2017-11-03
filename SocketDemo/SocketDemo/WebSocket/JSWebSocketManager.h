//
//  JSWebSocketManager.h
//  SocketDemo
//
//  Created by ecg on 2017/11/3.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import <Foundation/Foundation.h>


UIKIT_EXTERN NSString * const kJSWebSocketToolManagerReceivedServerDataNofificationKey;

@interface JSWebSocketManager : NSObject

- (__kindof JSWebSocketManager *)js_WebSocket_open;
- (void)js_WebSocket_sendData:(id)data;
- (void)js_WebSocket_close;

@end
