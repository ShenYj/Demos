//
//  CSocketManager.m
//  SocketDemo
//
//  Created by ecg on 2017/10/20.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import "CSocketManager.h"

@implementation CSocketManager

- (void)cSocketDemo
{
    // Do any additional setup after loading the view, typically from a nib.
    
    //1. 创建socket
    /**
     第一个参数---- 协议域 AF_INET 代表ipv4
     第二个参数---- 数据传输类型 SOCK_STREAM 流式socket (TCP)  SOCK_DGRAM 数据报式socket (UDP)
     第三个参数---- 传输协议  0 代表根据第二个参数自动选择
     
     返回值----- 返回的是socket 描述符
     */
    int clientSocket = socket(AF_INET, SOCK_DGRAM, 0);
    
    //2. 连接到服务器
    struct sockaddr_in address;
    // 不同的CPU 和 操作系统 对网络字节存储的方式是不一样的  (大尾\小尾 顺序)
    //htons 网络字节进行统一处理
    address.sin_port = htons(8081);
    //address.sin_addr.s_addr = inet_addr("119.75.218.70");
    address.sin_addr.s_addr = inet_addr("ws://221.216.94.95:8081/runtime.server/rt.ws");
    /**
     第一个参数: socket描述符
     第二个参数: 服务器的地址
     第三个参数: 服务器地址的长度
     返回值: 非零表示失败, 0 表示连接成功
     */
    int connectResult =  connect(clientSocket, (const struct sockaddr *)&address, sizeof(address));
    
    if (connectResult == 0){
        NSLog(@"连接成功");
    }else {
        NSLog(@"连接失败");
    }
    
    //3. 发送数据
    /**
     第二个参数: 发送的服务器的数据
     第三个参数: 发送数据的长度
     第四个参数: 发送标识, 一般传0
     */
    //char *sendMsg = "GET / HTTP / 1.1 \n \n";
    char *sendMsg = "SUBSCRIBE:828";
    send(clientSocket, sendMsg, strlen(sendMsg), 0);
    
    
    //4. 接收数据
    /**
     第二个参数,接收数据的缓冲区
     第三个参数, 数据缓冲区的长度
     第四个参数, 表示接收数据的形式, 是阻塞还是非阻塞, 一般传0 表示阻塞
     返回值,  返回接收到的数据长度
     */
    uint8_t buffer[1024];
    ssize_t recvSize  = recv(clientSocket, buffer, sizeof(buffer), 0);
    
    NSString *recvMsg = [[NSString alloc] initWithBytes:buffer length:recvSize encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",recvMsg);
    
}

@end
