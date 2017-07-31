//
//  JSWebSocketTool.m
//  WebSocketDemo
//
//  Created by ecg on 2017/7/31.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import "JSWebSocketTool.h"
#import "JSWebSocketManager.h"

NSString * const kJSWebSocketToolManagerStatus = @"kJSWebSocketToolManagerStatus";

#define WeakSelf(weakFlag) __weak typeof(self) weakFlag = self                              // 弱引用self
#define StrongSelf(strongFlag,weakFlag) __strong typeof(weakFlag) strongFlag = weakFlag     // 强引用self

static JSWebSocketTool *_instanceType = nil;

@interface JSWebSocketTool () <SRWebSocketDelegate>

@property (nonatomic,strong) JSWebSocketManager     *webSocket;         // JSWebSocket单例
@property (nonatomic,strong) dispatch_queue_t       socketQueue;        // socketQueue
@property (nonatomic,copy) id                       lastData;           // 发送的字符串数据,防止多次发送同一条数据

@end

@implementation JSWebSocketTool

#pragma mark - Public Method

/*** 单例 ***/
+ (instancetype)sharedWebSocketToolManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instanceType = [[JSWebSocketTool alloc] init];
    });
    return _instanceType;
}
/*** 构造函数 ***/
- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNetChanged:) name:AFNetworkingReachabilityNotificationStatusItem object:nil];
    }
    return self;
}

- (void)receivedNetChanged:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    NSLog(@" %s \n - %@",__func__,userInfo);
}

/*** 初始化WebSocket ***/
- (instancetype)js_WebSocket_initialWebSocketService
{
    self.webSocket = [JSWebSocketManager sharedWebSocketManager];
    self.webSocket.delegate = self;
    NSLog(@" 初始化完成");
    NSDictionary *userInfo = @{@"msg": @" 初始化完成"};
    [[NSNotificationCenter defaultCenter] postNotificationName:kJSWebSocketToolManagerStatus object:nil userInfo:userInfo];
    return self;
}
/*** 连接 ***/
- (void)js_WebSocket_open
{
    [self.webSocket open];
}
/*** 断开 ***/
- (void)js_WebSocket_close
{
    [self.webSocket close];
}

/*** 发送数据 ***/
- (void)js_WebSocket_sendData:(id)data
{
    if (self.lastData == data) {
        return;
    }
    
    self.lastData = data;
    
    WeakSelf(weakSelf);
    dispatch_async(self.socketQueue, ^{
        
        if (weakSelf.webSocket != nil) {
            
            // 只有 SR_OPEN 开启状态才能调 send 方法啊，不然要崩
            if (weakSelf.webSocket.readyState == SR_OPEN) {
                [weakSelf.webSocket send:data];    // 发送数据
                
            } else if (weakSelf.webSocket.readyState == SR_CONNECTING) {
                NSLog(@" 正在连接中，重连后其他方法会去自动同步数据");
                // 每隔2秒检测一次 socket.readyState 状态，检测 10 次左右
                // 只要有一次状态是 SR_OPEN 的就调用 [ws.socket send:data] 发送数据
                // 如果 10 次都还是没连上的，那这个发送请求就丢失了，这种情况是服务器的问题了，小概率的
                // 代码有点长，我就写个逻辑在这里好了
                __block int count = 0;
                [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
                    count++;
                    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
                    
                    if (count >= 10) {
                        [timer invalidate];
                        timer = nil;
                    }
                }];
                
            } else if (weakSelf.webSocket.readyState == SR_CLOSING || weakSelf.webSocket.readyState == SR_CLOSED) {
                // websocket 断开了，调用 reConnect 方法重连
                [weakSelf js_WebSocket_reConnect:^(BOOL result) {
                    
                    if (result) {
                        NSLog(@" 重连成功，继续发送刚刚的数据");
                        [weakSelf.webSocket send:data];
                    } else {
                        NSLog(@" 重连失败");
                    }
                }];
            }
            
        } else {
            NSLog(@" socket 为 nil");
        }
    });
}

/*** 重连方法 ***/
- (void)js_WebSocket_reConnect: (void(^)(BOOL result))handler
{
    NSLog(@" 重连方法");
}

#pragma mark - SRWebSocketDelegate

/*** 连接成功 ***/
- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    NSLog(@" 连接成功，可以立刻登录你公司后台的服务器了，还有开启心跳 (%@)",[NSThread currentThread]);
    NSDictionary *userInfo = @{@"msg": @" 连接成功，可以立刻登录你公司后台的服务器了"};
    [[NSNotificationCenter defaultCenter] postNotificationName:kJSWebSocketToolManagerStatus object:nil userInfo:userInfo];
}
/*** 连接失败 ***/
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    NSLog(@" 连接失败，这里可以实现掉线自动重连，要注意以下几点: (%@)",[NSThread currentThread]);
    NSLog(@" 1.判断当前网络环境，如果断网了就不要连了，等待网络到来，在发起重连");
    NSLog(@" 2.判断调用层是否需要连接，例如用户都没在聊天界面，连接上去浪费流量");
    NSLog(@" 3.连接次数限制，如果连接失败了，重试10次左右就可以了，不然就死循环了。 或者每隔1，2，4，8，10，10秒重连...f(x) = f(x-1) * 2, (x=5)");
    
    self.lastData = nil;
    NSDictionary *userInfo = @{@"msg": @" 连接失败"};
    [[NSNotificationCenter defaultCenter] postNotificationName:kJSWebSocketToolManagerStatus object:nil userInfo:userInfo];
}
/*** 连接关闭: 连接关闭不是连接断开，关闭是 [socket close] 客户端主动关闭，断开可能是断网了，被动断开的 ***/
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean
{
    NSLog(@" 连接断开，清空socket对象，清空该清空的东西，还有关闭心跳！(%@)",[NSThread currentThread]);
    
    NSDictionary *userInfo = @{@"msg": @" 连接断开，清空socket对象，清空该清空的东西，还有关闭心跳！"};
    [[NSNotificationCenter defaultCenter] postNotificationName:kJSWebSocketToolManagerStatus object:nil userInfo:userInfo];
    
    self.lastData = nil;;
}
/*** 收到服务器发来的数据 ***/
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    NSLog(@" 接收到数据 : %@ (__NSCFString)",message);
    
    NSDictionary *userInfo = @{@"msg": @"接收到数据."};
    [[NSNotificationCenter defaultCenter] postNotificationName:kJSWebSocketToolManagerStatus object:nil userInfo:userInfo];
}

#pragma mark - lazy

- (dispatch_queue_t)socketQueue {
    if (!_socketQueue) {
        _socketQueue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, DISPATCH_QUEUE_SERIAL);
    }
    return _socketQueue;
}

@end
