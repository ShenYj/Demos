//
//  OCSocketManager.m
//  SocketDemo
//
//  Created by ecg on 2017/10/20.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import "OCSocketManager.h"


static OCSocketManager *_instanceType = nil;

@interface OCSocketManager ()

@property (nonatomic,strong) GCDAsyncUdpSocket *udpSocket;

@end


@implementation OCSocketManager 

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instanceType = [[OCSocketManager alloc] init];
        _instanceType.udpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    });
    return _instanceType;
}

- (void)socket_Open
{
    
    NSError *error = nil;
    [self.udpSocket connectToHost:@"" onPort:8081 error:&error];
}

#pragma mark - <GCDAsyncUdpSocketDelegate>

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didConnectToAddress:(NSData *)address
{
    NSLog(@"%s",__func__);
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotConnect:(NSError * _Nullable)error
{
    NSLog(@"%s",__func__);
}
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
    NSLog(@"%s",__func__);
}
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError * _Nullable)error
{
    NSLog(@"%s",__func__);
}
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data
      fromAddress:(NSData *)address
withFilterContext:(nullable id)filterContext
{
    NSLog(@"%s",__func__);
}
- (void)udpSocketDidClose:(GCDAsyncUdpSocket *)sock withError:(NSError  * _Nullable)error
{
    NSLog(@"%s",__func__);
}

@end
