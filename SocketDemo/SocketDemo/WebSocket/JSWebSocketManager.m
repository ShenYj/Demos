//
//  JSWebSocketManager.m
//  SocketDemo
//
//  Created by ecg on 2017/11/3.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import <SocketRocket.h>
#import <UIKit/UIKit.h>
#import "JSWebSocketManager.h"


#define WebSocketRequestUrlStringDeveloper @"ws://221.216.94.95:8081/runtime.server/rt.ws" //测试

NSInteger const kJSWebSocketReConnectOffset                               = 60;           // 重连定时器间隔
NSString * const kJSWebSocketToolManagerStatus                            = @"kJSWebSocketToolManagerStatus";
NSString * const kJSWebSocketTransportStatusChangedKey                    = @"kJSWebSocketTransportStatusChangedKey";
NSString * const kJSWebSocketToolManagerTransportDataKey                  = @"kJSWebSocketToolManagerTransportDataKey";
NSString * const kJSWebSocketTransportStatusChangedNotificationKey        = @"kJSWebSocketTransportStatusChangedNotificationKey";
NSString * const kJSWebSocketToolManagerTransportDataNotificationKey      = @"NSString * const kJSWebSocketToolManagerTransport;";
NSString * const kJSWebSocketToolManagerReceivedServerDataNofificationKey = @"kJSWebSocketToolManagerReceivedServerDataNofificationKey";

//static SRWebSocket *_instanceType = nil;

@interface JSWebSocketManager () <SRWebSocketDelegate>
{
    dispatch_queue_t _socketQueue;
}
@property (nonatomic,strong) SRWebSocket      *webSocket;         // WebSocket
@property (nonatomic,  copy) id               sendData;           // 发送的字符串数据,防止多次发送同一条数据
@property (nonatomic,strong) NSTimer          *reConectTimer;     // WebSocket重连定时器
/*** 连接状态检查: 15s内是否有数据 ***/
@property (nonatomic,strong) NSTimer          *isTransportTimer;  // 用于检查连接状态,如果超过15s没有数据,则代表断开
@property (nonatomic,assign) NSInteger        index;              // 检查连接状态的统计
@property (nonatomic,assign) BOOL             haveData;           // 连接状态
//@property (nonatomic,assign) BOOL             appIsInForceground; // 应用处于前台或回到前台

@end

@implementation JSWebSocketManager

#pragma mark - Public Method

- (void)dealloc
{
    [self js_WebSocket_StopToReConectTimer];
    [self stopToCheckDataTransport];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//+ (__kindof SRWebSocket *)sharedSRWebSocket
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _instanceType =  [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:WebSocketRequestUrlStringDeveloper]]];
//    });
//    return _instanceType;
//}

/*** 构造函数 ***/
- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化Socket队列
        _socketQueue = dispatch_queue_create("WebSocket GCD Queue", DISPATCH_QUEUE_SERIAL);
        // 监听通知 : 应用前后台 蓝牙状态
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(applicationWillEnterForegroundNotification:)
                                                     name: UIApplicationWillEnterForegroundNotification
                                                   object: [UIApplication sharedApplication]];
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(applicationWillResignActiveNotification:)
                                                     name: UIApplicationWillResignActiveNotification
                                                   object: [UIApplication sharedApplication]];
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(applicationEnterBackgroundNotification:)
                                                     name: UIApplicationDidEnterBackgroundNotification
                                                   object: [UIApplication sharedApplication]];
    }
    return self;
}
/*** 应用将要进入前台 ***/
- (void)applicationWillEnterForegroundNotification:(NSNotification *)notification
{
    NSLog(@"------ WebSocket -----> 将要进入前台");
    // 前台标识
//    self.appIsInForceground = YES;
    [self js_WebSocket_open];
}
/*** 应用进将要失去焦点 ***/
- (void)applicationWillResignActiveNotification:(NSNotification *)notification
{
    NSLog(@"------ WebSocket -----> 将要失去焦点");
//    self.appIsInForceground = NO;
    [self js_WebSocket_close];
}
/*** 应用进入后台 ***/
- (void)applicationEnterBackgroundNotification:(NSNotification *)notification
{
    NSLog(@"------ WebSocket -----> 已经进入后台");
//    self.appIsInForceground = NO;
}

#pragma mark - 检查连接状态 15s内是否有推送数据

- (void)startToCheckDataTransport
{
    self.index = 0;
    self.haveData = NO;
    if (self.isTransportTimer) return;
    self.isTransportTimer = [NSTimer scheduledTimerWithTimeInterval: 1
                                                             target: self
                                                           selector: @selector(webSocketReceivedDataTimer:)
                                                           userInfo: nil
                                                            repeats: YES];
    [[NSRunLoop currentRunLoop] addTimer: self.isTransportTimer
                                 forMode: NSRunLoopCommonModes];
}
- (void)stopToCheckDataTransport
{
    [self.isTransportTimer invalidate];
    self.isTransportTimer = nil;
    self.index = 0;
}
- (void)webSocketReceivedDataTimer:(NSTimer *)timer
{
    self.index ++;
    NSLog(@"数据推送状态检查定时器:  %zd 秒 ",self.index);
    if (self.index > 15) {
        self.haveData = NO;
        self.index = (self.index > 99) ? 16 : self.index;
        if (self.index > 16) return; // 只发送一次
        NSDictionary *userInfo = @{kJSWebSocketTransportStatusChangedKey: @(self.haveData)};
        [[NSNotificationCenter defaultCenter] postNotificationName: kJSWebSocketTransportStatusChangedNotificationKey
                                                            object: nil
                                                          userInfo: userInfo];
    }
}

#pragma mark - 重连方法
/*** 重连方法 ***/
- (void)js_WebSocket_reConnect
{
    if (self.reConectTimer) {
        NSLog(@"重连的定时器方法已经开启");
        return;
    }
    
    NSLog(@"重新连接WebSocket");
    self.reConectTimer = [NSTimer scheduledTimerWithTimeInterval: kJSWebSocketReConnectOffset
                                                          target: self
                                                        selector: @selector(reConnectWebSocketTimer:)
                                                        userInfo: nil
                                                         repeats: YES];
    [[NSRunLoop currentRunLoop] addTimer: self.reConectTimer
                                 forMode: NSRunLoopCommonModes];
}
- (void)js_WebSocket_StopToReConectTimer
{
    if (self.reConectTimer) {
        [self.reConectTimer invalidate];
        self.reConectTimer = nil;
    }
}
- (void)reConnectWebSocketTimer:(NSTimer *)timer
{
    if ( self.webSocket.readyState == SR_OPEN) {
        [self js_WebSocket_StopToReConectTimer];
        NSLog(@"WebSocket的连接已经建立, 关闭定时器");
        
        return;
    }
//    [self js_WebSocket_close];
//    self.webSocket = nil;
    
    [self js_WebSocket_open];
    NSLog(@"************************** 重连中...%zd **************************",self.webSocket.readyState);
}

#pragma mark - WebSocket

/*** 初始化WebSocket并建立连接 ***/
- (void)js_WebSocket_open
{
    if (self.webSocket) {
        NSLog(@" webSocket 已存在");
        if (self.webSocket.readyState == SR_CONNECTING) {
            NSLog(@"----> SR_CONNECTING");
            // 重连
            [self js_WebSocket_reConnect];
            return ;
        } else if (self.webSocket.readyState == SR_CLOSING) {
            NSLog(@"----> SR_CLOSING");
            // 重连
            [self js_WebSocket_reConnect];
            return ;
        } else if (self.webSocket.readyState == SR_CLOSED) {
            NSLog(@"----> SR_CLOSED");
            // 重连
            [self js_WebSocket_reConnect];
            return ;
        } else {
            // OPEN
            NSLog(@"----> SR_OPEN");
            [self js_WebSocket_sendData:self.sendData];
            return ;
        }
    }
    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:WebSocketRequestUrlStringDeveloper]]];
//    self.webSocket = [JSWebSocketManager sharedSRWebSocket];
    self.webSocket.delegate = self;
    
    // 开启定时器,进行状态检查
    [self startToCheckDataTransport];
    
    NSLog(@" 初始化完成");
    [self.webSocket open];
    NSLog(@"   WebSocket 当前状态: %zd",self.webSocket.readyState);
}
/*** 断开 ***/
- (void)js_WebSocket_close
{
    // 关闭WebSocket
    if (self.webSocket) {
        //        [self.webSocket close];
        [self.webSocket closeWithCode:SRStatusCodeNormal reason:@"手动关闭"];
//        self.webSocket = nil;
    }
    // 关闭重连定时器
    if (self.reConectTimer) {
        [self js_WebSocket_StopToReConectTimer];
    }
    // 关闭WebSocket通信状态
    if (self.isTransportTimer) {
        [self stopToCheckDataTransport];
    }
}
/*** 发送数据 ***/
- (void)js_WebSocket_sendData:(id)data
{
    self.sendData = data;
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(_socketQueue, ^{
        
        if (weakSelf.webSocket != nil) {
            
            // 只有 SR_OPEN 开启状态才能调 send 方法啊，否则会crash
            if (weakSelf.webSocket.readyState == SR_OPEN) {
                [weakSelf.webSocket send:self.sendData];     // 发送数据
            } else if (weakSelf.webSocket.readyState == SR_CONNECTING) {
                // 正在连接中
            } else if (weakSelf.webSocket.readyState == SR_CLOSING ||
                       weakSelf.webSocket.readyState == SR_CLOSED) {
                [self js_WebSocket_reConnect];      // 重连
            } else {
                [self js_WebSocket_reConnect];      // 重连
            }
        } else {
            NSLog(@" socket 为 nil");
            [self js_WebSocket_reConnect];          // 重连
        }
    });
}

#pragma mark - SRWebSocketDelegate

/*** 连接成功 ***/
- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    if (webSocket == self.webSocket) {
        NSLog(@"************************** socket 连接成功 **************************");
        if (self.sendData) {
            [self js_WebSocket_sendData:self.sendData];
        }
    }
}
/*** 连接失败 ***/
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
    NSLog(@"************************** socket 连接失败 **************************");
    // 重连
    [self js_WebSocket_reConnect];
}
/*** 连接关闭: 连接关闭不是连接断开，关闭是 [socket close] 客户端主动关闭，断开可能是断网了，被动断开的 ***/
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean
{
    NSLog(@"************************** socket 连接关闭 **************************");
    NSLog(@"************************** code: %zd",code);
    NSLog(@"************************** reason: %@",reason);
    NSLog(@"************************** wasClean: %d",wasClean);
    // 停止检查传输数据状态
    [self stopToCheckDataTransport];
    self.webSocket.delegate = nil;
//    self.webSocket = nil;
    
//    if (self.appIsInForceground) {
//        // 应用回到前台
//        [self js_WebSocket_reConnect];
//    }
}
/*** 收到服务器发来的数据 ***/
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    NSLog(@"************************** 收到服务器发来的数据 **************************");
    self.index = 0;
    self.haveData = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName: kJSWebSocketToolManagerReceivedServerDataNofificationKey
                                                        object: nil
                                                      userInfo: nil];
}

@end
