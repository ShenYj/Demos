//
//  BluetoothManager.m
//  蓝牙(CoreBluetooth)
//
//  Created by ecg on 2017/4/6.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "BluetoothManager.h"
#import <UIKit/UIKit.h>

#define JSLOG NSLog(@"%s",__func__);        // LOG
#define iOS10 (([UIDevice currentDevice].systemVersion.floatValue) >= (10.0)) // iOS 10
#define ECG_SERVICE_UUID @"serviceUUID"         //备用
#define ECG_CHAR_UUID @"characterUUID"          //备用

static BluetoothManager *_instanceType = nil;
static NSString * const kMyCentralManagerIdentifier = @"kMyCentralManagerIdentifier";
/*** 默认超时时间 60s ***/
static int const kTimeOut = 60;



@interface BluetoothManager ()

/*** 当前是否正在搜索蓝牙设备 ***/
@property (nonatomic,assign) BOOL isScanning;
/*** 记录手动设置的超时时长 ***/
@property (nonatomic,assign) int timeOut;
/*** 中央设备： 手机端 ***/
@property (nonatomic,strong) CBCentralManager *centralManager;
/*** 蓝牙设备 ***/
@property (nonatomic,strong) CBPeripheral *peripheral;

@property (nonatomic,strong) CBCharacteristic *writeCharacter;

@end

@implementation BluetoothManager

+ (instancetype)sharedCentralBluetoothManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instanceType = [[BluetoothManager alloc] init];
        _instanceType.isScanning = NO;
    });
    return _instanceType;
}

#pragma mark - 扫描蓝牙设备
-(void)scanBluetoothWith:(int)timeout
{
    timeout <= 30 ? (self.timeOut = kTimeOut) : (self.timeOut = timeout);
    
    self.isScanning = self.centralManager.isScanning;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        switch (self.centralManager.state) {
            case CBCentralManagerStateUnknown:         // 未知
            case CBCentralManagerStateResetting:       // 正在重启
            case CBCentralManagerStateUnsupported:     // 不支持
            case CBCentralManagerStateUnauthorized:    // 未授权
                break;
            case CBCentralManagerStatePoweredOff:      // 关闭蓝牙
            {
                // 提示用户是否要开启蓝牙
                [self noticeUserToOpenBluetoothService];
            }
                break;
            case CBCentralManagerStatePoweredOn:       // 开启蓝牙
            {
                // 扫描外设
                [self scanBluetoothDevices];
            }
                break;
            default:
                break;
        }
    });
    
    /*
    if (self.centralManager.state == CBCentralManagerStatePoweredOn)
    {
        [self.centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:@"0xFFF0"],[CBUUID UUIDWithString:@"0xFFE0"],[CBUUID UUIDWithString:@"0x18F0"]] options:0];
    }
     [NSTimer scheduledTimerWithTimeInterval:timeout target:self selector:@selector(stopScanfBluetooth:) userInfo:nil repeats:NO];
     */
}

#pragma mark - 蓝牙关闭状态，切换至系统设置-蓝牙开启关闭界面
- (void)noticeUserToOpenBluetoothService
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否打开蓝牙？" message:@"点击‘是’将跳转至蓝牙设置界面" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okey = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openBluetooth];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:okey];
    [alertController addAction:cancel];
    
    // 展示alert提示框
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    
    // 系统默认提醒 ： 设置  &  好
    //[self openBluetooth];
}
/*** 打开蓝牙开关 ***/
- (void)openBluetooth
{
    JSLOG
    if (iOS10) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    } else {
        NSURL *url = [NSURL URLWithString:@"prefs:root=General&path=Bluetooth"];
        if ([[UIApplication sharedApplication] canOpenURL:url] )
        {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
    
}

/*** 扫描蓝牙设备 ***/
- (void)scanBluetoothDevices
{
    // 扫描设置
    if (self.isScanning == NO )
    {
        JSLOG
        // @[[CBUUID UUIDWithString:@"0xFFF0"],[CBUUID UUIDWithString:@"0xFFE0"],[CBUUID UUIDWithString:@"0x18F0"]]
        [self.centralManager scanForPeripheralsWithServices:nil options:0];
        [NSTimer scheduledTimerWithTimeInterval:self.timeOut target:self selector:@selector(stopScanBluetooth:) userInfo:nil repeats:NO];
        self.isScanning = YES;
    }
}

#pragma mark - 停止扫描蓝牙 (定时器方法)
- (void)stopScanBluetooth:(NSTimer *)timer
{
    [self.centralManager stopScan];
    self.isScanning = NO;
    [timer invalidate];
    timer = nil;
}
/*** 对外接口： 停止扫描蓝牙设备 ***/
- (void)stopToScanBluetoothPeripheral
{
    [self.centralManager stopScan];
    self.isScanning = NO;
}


#pragma mark - 连接蓝牙
- (void)connect:(CBPeripheral *)peripheral
{
    if (peripheral.state == CBPeripheralStateDisconnected)
    {
        [self.centralManager connectPeripheral:peripheral options:nil];
    }
}

#pragma mark - 断开蓝牙
- (void)disconnect:(CBPeripheral *)peripheral
{
    [self.centralManager cancelPeripheralConnection:peripheral];
}

#pragma mark - 发送命令
- (void)write:(CBPeripheral *)peripheral data:(NSString *)data
{
    [peripheral writeValue: [self convertHexStrToData:data]forCharacteristic:self.writeCharacter type:CBCharacteristicWriteWithoutResponse];
}

#pragma mark - 读取外设信息
- (void)read:(CBPeripheral *)peripheral
{
    
}

/**
 *  设备通知
 */
- (void)notify:(CBPeripheral *)peripheral on:(BOOL)on
{
    
}




#pragma mark
#pragma mark - CBCentralManagerDelegate

/*** 中心设备更新状态时调用 ***/
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    
    // 判断状态
    /*
    switch (central.state)
    {
        case CBCentralManagerStateUnknown:         // 未知
        case CBCentralManagerStateResetting:       // 正在重启
        case CBCentralManagerStateUnsupported:     // 不支持
        case CBCentralManagerStateUnauthorized:    // 未授权
        case CBCentralManagerStatePoweredOff:      // 关闭蓝牙
            
            break;
        case CBCentralManagerStatePoweredOn:       // 开启蓝牙
            
            break;
        default:
            break;
    }
     */
}

/*** 扫描到蓝牙时调用 ***/
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    // 记录搜索到的外设
    if (![self.allowToConnectPeripherals containsObject:peripheral]) {
        [self.allowToConnectPeripherals addObject:peripheral];
    }
    
    if (self.allowToConnectPeripherals.count == 0) {
        return;
    }
    
    // 发现设备
    if ([self.delegate respondsToSelector:@selector(js_peripheralFounded:)]) {
        [self.delegate js_peripheralFounded:self.allowToConnectPeripherals];
    }
    
}

/*** 连接上设备时调用 ***/
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    self.peripheral = peripheral;
    self.peripheral.delegate = self;
    [self.peripheral discoverServices:nil];
    if ([self.delegate respondsToSelector:@selector(js_peripheralConnected)]) {
        
        [self.delegate js_peripheralConnected];
    }
}


#pragma mark
#pragma mark - CBPeripheralDelegate

/*** 发现服务时调用 ***/
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error
{
    for (CBService *service in peripheral.services)
    {
        if ([service.UUID isEqual:[CBUUID UUIDWithString:ECG_SERVICE_UUID]])
        {
            NSLog(@"发现20P的服务: %@", service.UUID);
            [peripheral discoverCharacteristics:nil forService:service];
            
            break;
        }
    }
}

/*** 发现特征时调用 ***/
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error
{
    for (CBCharacteristic *characteristic in service.characteristics)
    {
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:ECG_CHAR_UUID]])
        {
            NSLog(@"发现20P的特征:%@ for service: %@", characteristic.UUID, service.UUID);
            
            self.writeCharacter = characteristic;//保存读的特征
            break;
        }
    }
}





#pragma mark - 十六进制转换为NSData数据流
- (NSData *)convertHexStrToData:(NSString *)str
{
    if (!str || [str length] == 0)
    {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    
    return hexData;
}

#pragma mark
#pragma mark - 懒加载

- (CBCentralManager *)centralManager
{
    if (!_centralManager)
    {
        //  options:@{CBCentralManagerOptionRestoreIdentifierKey : @"kMyCentralManagerIdentifier"}
        _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return _centralManager;
}

- (NSMutableArray *)allowToConnectPeripherals {
    if (!_allowToConnectPeripherals) {
        _allowToConnectPeripherals = [NSMutableArray array];
    }
    return _allowToConnectPeripherals;
}

@end
