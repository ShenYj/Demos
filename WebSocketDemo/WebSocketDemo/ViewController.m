//
//  ViewController.m
//  WebSocketDemo
//
//  Created by ecg on 2017/7/31.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import "ViewController.h"
#import <SocketRocket.h>


/******************************************************
 
 @discusstion:   未封装
 
 @author：   ShenYj
 
 @email:    shenyj4@51nb.com
 
 ******************************************************/


#define WeakSelf(object) __weak typeof(self) object = self

@interface ViewController () <SRWebSocketDelegate>

@property (nonatomic,strong) SRWebSocket *socket;
@property (nonatomic,assign) dispatch_queue_t socketQueue;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ip地址:端口"]]];
    self.socket.delegate = self;     // 实现这个 SRWebSocketDelegate 协议啊
    [self.socket open];              // open 就是直接连接了
}

/*** 发送数据 ***/
- (void)sendData:(id)data
{
    WeakSelf(weakSelf);
    dispatch_async(self.socketQueue, ^{
        if (weakSelf.socket != nil) {
            // 只有 SR_OPEN 开启状态才能调 send 方法啊，不然要崩
            if (weakSelf.socket.readyState == SR_OPEN) {
                [weakSelf.socket send:data];    // 发送数据
                
            } else if (weakSelf.socket.readyState == SR_CONNECTING) {
                NSLog(@"正在连接中，重连后其他方法会去自动同步数据");
                // 每隔2秒检测一次 socket.readyState 状态，检测 10 次左右
                // 只要有一次状态是 SR_OPEN 的就调用 [ws.socket send:data] 发送数据
                // 如果 10 次都还是没连上的，那这个发送请求就丢失了，这种情况是服务器的问题了，小概率的
                // 代码有点长，我就写个逻辑在这里好了
                
            } else if (weakSelf.socket.readyState == SR_CLOSING || weakSelf.socket.readyState == SR_CLOSED) {
                // websocket 断开了，调用 reConnect 方法重连
                [weakSelf reConnect:^(BOOL result) {
                    
                    if (result) {
                        
                        NSLog(@"重连成功，继续发送刚刚的数据");
                        [weakSelf.socket send:data];
                        
                    } else {
                        
                        NSLog(@"重连失败");
                    }
                }];
            }
            
        } else {
            NSLog(@" 没网络，发送失败，一旦断网 socket 会被我设置 nil 的");
            NSLog(@" 其实最好是发送前判断一下网络状态比较好，我写的有点晦涩，socket==nil来表示断网");
        }
    });
}

/*** 重连方法 ***/
- (void)reConnect: (void(^)(BOOL result))handler
{
    NSLog(@"重连方法");
}


#pragma mark - SRWebSocketDelegate

/*** 连接成功 ***/
- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    NSLog(@"连接成功，可以立刻登录你公司后台的服务器了，还有开启心跳");
}
/*** 连接失败 ***/
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    NSLog(@" 连接失败，这里可以实现掉线自动重连，要注意以下几点:");
    NSLog(@" 1.判断当前网络环境，如果断网了就不要连了，等待网络到来，在发起重连");
    NSLog(@" 2.判断调用层是否需要连接，例如用户都没在聊天界面，连接上去浪费流量");
    NSLog(@" 3.连接次数限制，如果连接失败了，重试10次左右就可以了，不然就死循环了。 或者每隔1，2，4，8，10，10秒重连...f(x) = f(x-1) * 2, (x=5)");
}
/*** 连接关闭: 连接关闭不是连接断开，关闭是 [socket close] 客户端主动关闭，断开可能是断网了，被动断开的 ***/
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean
{
    NSLog(@" 连接断开，清空socket对象，清空该清空的东西，还有关闭心跳！");
}
/*** 收到服务器发来的数据 ***/
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    NSLog(@" 接收到数据 : %@",message);
}


@end
