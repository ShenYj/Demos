//
//  JSBluetoothManager.h
//  CorebluetoothManager
//
//  Created by ShenYj on 2017/4/5.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
@class JSBluetoothManager;


static NSString * const JSCentralErrorConnectTimeOut = @" connect time out ";
static NSString * const jsCentralErrorScanTimeOut = @" scan time out ";
static NSString * const JSCentralErrorConnectOthers = @" other error ";
static NSString * const JSCentralErrorConnectPowerOff = @" power off ";
static NSString * const JSCentralErrorConnectAutoConnectFail = @" auto connect fail ";
static NSString * const JSCentralErrorWriteDataLength = @" data length error ";


@protocol JSBluetoothToolDelegate <NSObject>
@optional
/*** 扫描到蓝牙设备时调用 ***/
- (void)js_peripheralFounded:(NSArray <CBPeripheral *>*)peripherals;
/*** 连接上设备时调用 ***/
- (void)js_peripheralConnected:(CBPeripheral *)peripheral;
/*** 断开连接时调用 ***/
- (void)js_peripheralDisconnected:(CBPeripheral *)peripheral;
/** 设备状态变化:  连接失败（包括超时、连接错误等） */
- (void)js_centralTool:(JSBluetoothManager *)bluetoothManager connectFailure:(NSError *)error;

/*** 出现低电量时调用 ***/
- (void)js_lowBattery;
/*** 读取设备版本号 ***/
- (void)js_ballVersions:(NSString *)versions;
/*** 读取设备ID ***/
- (void)js_ID:(NSString *)str;
@end



@interface JSBluetoothManager : NSObject <CBCentralManagerDelegate,CBPeripheralDelegate>

/** 单例: 蓝牙管理者(中央端) */
+ (instancetype)sharedManager;
#warning 新增
/** 设备蓝牙启用 */
@property (nonatomic,assign,getter=deviceBluetoothIsOn) BOOL deviceBluetoothOn;
/** 连接状态 */
@property (nonatomic,assign,getter=deviceIsConnecting) BOOL deviceConnecting;

/*** 代理 ***/
@property (nonatomic,weak) id <JSBluetoothToolDelegate> delegate;

/*** 中央设备： 手机端 ***/
@property (nonatomic,strong) CBCentralManager *centralManager;
/*** 存储搜索到的周边外设 ***/
@property (nonatomic,strong) NSMutableArray *allowToConnectPeripherals;


/**
 *  扫描蓝牙
 *
 *  @param timeout 超时时长, 如果指定时长<=1 ，则默认时长为 60s
 */
- (void)scanBluetoothWith:(int)timeout;
/**
 *  停止扫描
 */
- (void)stopToScanBluetoothPeripheral;
/**
 *  连接设备
 *
 *  @param peripheral 扫描到的蓝牙设备
 */
- (void)connect:(CBPeripheral *)peripheral;
/**
 *  断开设备
 *
 *  @param peripheral 需要断开的蓝牙设备
 */
- (void)disconnect:(CBPeripheral *)peripheral;



#warning 读写数据
/**
 *  给设备发送指令
 */
- (void)write:(CBPeripheral *)peripheral data:(NSString *)data;
/**
 *  读取蓝牙设备广播信息
 */
- (void)read:(CBPeripheral *)peripheral;
/**
 *  设备通知
 */
- (void)notify:(CBPeripheral *)peripheral on:(BOOL)on;


@end
