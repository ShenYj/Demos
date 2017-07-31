//
//  JSViewController.m
//  WebSocketDemo
//
//  Created by ecg on 2017/7/31.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import "JSViewController.h"
#import "JSWebSocketTool.h"

/******************************************************
 
 @discusstion:   封装后
 
 @author：   ShenYj
 
 @email:    shenyj4@51nb.com
 
 ******************************************************/

extern NSString * const kJSWebSocketToolManagerStatus;

@interface JSViewController ()

@property (weak, nonatomic) IBOutlet UIButton *initialWebSocket;        // 初始化
@property (weak, nonatomic) IBOutlet UIButton *connectWebSocket;        // 连接
@property (weak, nonatomic) IBOutlet UIButton *closeWebSocket;          // 断开
@property (weak, nonatomic) IBOutlet UIButton *sendData;                // 发送数据按钮
@property (weak, nonatomic) IBOutlet UILabel  *describeLabel;           // 顶部描述Label
@property (weak, nonatomic) IBOutlet UILabel  *noticeLabel;             // 底部状态展示Label

@end

@implementation JSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.describeLabel.text = @"操作步骤:\n 1.初始化WebSocket\n 2. 连接\n  3. 发送数据准备开始接收服务器推送的数据\n  4. 断开连接\n";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedWebSocketToolManagerStatusChangedNotification:) name:kJSWebSocketToolManagerStatus object:nil];
    // 按钮点击事件
    [self.initialWebSocket addTarget:self action:@selector(initialWebSocketButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.connectWebSocket addTarget:self action:@selector(connectWebSocketButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.closeWebSocket addTarget:self action:@selector(closeWebSocketButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.sendData addTarget:self action:@selector(sendDataButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)receivedWebSocketToolManagerStatusChangedNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    self.noticeLabel.text = userInfo[@"msg"];
}

#pragma mark - Target

- (void)initialWebSocketButton:(UIButton *)sender
{
    [[JSWebSocketTool sharedWebSocketToolManager] js_WebSocket_initialWebSocketService];
}
- (void)connectWebSocketButton:(UIButton *)sender
{
    [[JSWebSocketTool sharedWebSocketToolManager] js_WebSocket_open];
}
- (void)closeWebSocketButton:(UIButton *)sender
{
    [[JSWebSocketTool sharedWebSocketToolManager] js_WebSocket_close];
}
- (void)sendDataButton:(UIButton *)sender
{
    NSString *dataString = [NSString stringWithFormat:@"SUBSCRIBE:%d",828];
    [[JSWebSocketTool sharedWebSocketToolManager] js_WebSocket_sendData:dataString];
}


@end
