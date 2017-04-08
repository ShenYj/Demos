//
//  JSBluetoothManager.h
//  CorebluetoothManager
//
//  Created by ShenYj on 2017/4/5.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
@class BluetoothManager;

@protocol JSBluetoothToolDelegate <NSObject>
@optional
/*** 扫描到蓝牙设备时调用 ***/
- (void)js_peripheralFounded:(NSArray <CBPeripheral *>*)peripherals;
/*** 连接上设备时调用 ***/
- (void)js_peripheralConnected;
/*** 断开连接时调用 ***/
- (void)js_peripheralDisconnected;
/*** 出现低电量时调用 ***/
- (void)js_lowBattery;
/*** 读取设备版本号 ***/
- (void)js_ballVersions:(NSString *)versions;
/*** 读取设备ID ***/
- (void)js_ID:(NSString *)str;
@end


/** 检索设备蓝牙状态 */
@protocol JSCentralDeviceStateDelegate <NSObject>
@optional
/** 未知 */
- (void)js_centralManagerStateUnknown;
/** 正在重启 */
- (void)js_centralManagerStateResetting;
/** 不支持 */
- (void)js_centralManagerStateUnsupported;
/** 未授权 */
- (void)js_centralManagerStateUnauthorized;
/** 关闭蓝牙 */
- (void)js_centralManagerStatePoweredOff;
/** 开启蓝牙 */
- (void)js_centralManagerStatePoweredOn;

@end


@interface JSBluetoothManager : NSObject <CBCentralManagerDelegate,CBPeripheralDelegate>

/** 单例: 蓝牙管理者(中央端) */
+ (instancetype)sharedManager;
/*** 代理 ***/
@property (nonatomic,weak) id <JSBluetoothToolDelegate> delegate;
/** 代理:监听状态 */
@property (nonatomic,weak) id <JSCentralDeviceStateDelegate> stateDelegate;
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
