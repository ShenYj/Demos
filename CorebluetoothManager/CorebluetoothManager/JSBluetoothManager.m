//
//  JSBluetoothManager.m
//  CorebluetoothManager
//
//  Created by ShenYj on 2017/4/5.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSBluetoothManager.h"
#import <UIKit/UIKit.h>

#define JSLOG NSLog(@"%s",__func__);                                            // LOG
#define iOS10 (([UIDevice currentDevice].systemVersion.floatValue) >= (10.0))   // iOS 10
#define ECG_SERVICE_UUID @"DDAB6486-CBF1-47A5-B939-F3CAA527F834"                //备用
#define ECG_CHAR_UUID @"2795B687-FF83-46E0-B485-D9174ED37E8A"                   //备用

static JSBluetoothManager *_instanceType = nil;
static NSString * const kMyCBCentralManagerOptionRestoreIdentifierKey = @"CBCentralManagerOptionRestoreIdentifierKey";

/*** 默认超时时间 60s ***/
static int const kTimeOut = 60;

@interface JSBluetoothManager ()

/*** 当前是否正在搜索蓝牙设备 ***/
@property (nonatomic,assign) BOOL isScanning;
/*** 记录手动设置的超时时长 ***/
@property (nonatomic,assign) int timeOut;

/*** 蓝牙设备 ***/
@property (nonatomic,strong) CBPeripheral *peripheral;

@property (nonatomic,strong) CBCharacteristic *writeCharacter;


#warning 新增
@property (nonatomic,strong) NSTimer *timer;
/** 提示框 */
@property (nonatomic,weak) UIAlertController *alertController;

@end

@implementation JSBluetoothManager

+ (void)load {
    // 程序一启动就开始获取设备状态 (默认一启动时设备状态为未知,暂时这里手动调用了一下获取设备状态的协议方法)
    [[JSBluetoothManager sharedManager] centralManagerDidUpdateState:[JSBluetoothManager sharedManager].centralManager];
    [JSBluetoothManager sharedManager].timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(getCentralDeviceState) userInfo:nil repeats:YES];

}

+ (void)getCentralDeviceState
{
    JSBluetoothManager *manager = [JSBluetoothManager sharedManager];
    BOOL isOn = manager.centralManager.state == CBCentralManagerStatePoweredOn;
    manager.deviceBluetoothOn = isOn;
    NSLog(@"设备启用状态:%zd,设备连接状态:%zd",manager.deviceBluetoothIsOn,manager.deviceIsConnecting);
    
    // 蓝牙关闭
    if (!isOn) {
        // 自定义alert提示框已在界面中显示 || 当前应用不再前台 不做任何处理
        UIApplicationState appState = [UIApplication sharedApplication].applicationState;
        if (manager.alertController || appState != UIApplicationStateActive) {
            return;
        }
        // 提示蓝牙关闭
        [manager noticeUserToOpenBluetoothService];
        return;
    } else {
        // 蓝牙开启
        BOOL isConnected = manager.deviceIsConnecting;
        if (isConnected) {
            // 开启并连接状态
            NSLog(@"--->当前设备处于连接状态");
            return;
        } else {
            // 开启但断开连接状态
            // 如果有绑定设备,自动搜索并连接
            if (manager.peripheral) {
                [manager.centralManager connectPeripheral:manager.peripheral options:nil];
                NSLog(@"---->重新连接到设备");
            }
        }
        
    }
    
}

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instanceType = [[JSBluetoothManager alloc] init];
        _instanceType.isScanning = NO;
        _instanceType.deviceBluetoothOn = NO;
        _instanceType.deviceConnecting = NO;
    });
    return _instanceType;
}


#pragma mark - 扫描蓝牙设备
-(void)scanBluetoothWith:(int)timeout
{
    timeout <= 30 ? (self.timeOut = kTimeOut) : (self.timeOut = timeout);
    
    if (self.deviceBluetoothIsOn) {
        // 蓝牙开启
        [self scanBluetoothDevices]; // 扫描外设
    } else {
        // 其他状态
        [self noticeUserToOpenBluetoothService];// 提示用户是否开启蓝牙
    }
    
//    self.isScanning = self.centralManager.isScanning;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        switch (self.centralManager.state) {
//            case CBCentralManagerStateUnknown:         // 未知
//            case CBCentralManagerStateResetting:       // 正在重启
//            case CBCentralManagerStateUnsupported:     // 不支持
//            case CBCentralManagerStateUnauthorized:    // 未授权
//                break;
//            case CBCentralManagerStatePoweredOff:      // 关闭蓝牙
//            {
//                // 提示用户是否要开启蓝牙
//                [self noticeUserToOpenBluetoothService];
//            }
//                break;
//            case CBCentralManagerStatePoweredOn:       // 开启蓝牙
//            {
//                // 扫描外设
//                [self scanBluetoothDevices];
//            }
//                break;
//            default:
//                break;
//        }
//    });
    
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
    self.alertController = alertController;
    // 展示alert提示框
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    
}
/*** 打开蓝牙开关 ***/
- (void)openBluetooth
{
#warning 跳转到蓝牙设置界面,指导用户开启蓝牙
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    if (iOS10) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-Prefs:root=Bluetooth"] options:@{UIApplicationOpenURLOptionUniversalLinksOnly: [NSNumber numberWithBool:NO]} completionHandler:nil];
//        NSURL *url = [NSURL URLWithString:@"App-Prefs:root=Bluetooth"];
//        if ([[UIApplication sharedApplication] canOpenURL:url] )
//        {
//            [[UIApplication sharedApplication] openURL:url];
//        }

    } else {
        NSURL *url = [NSURL URLWithString:@"prefs:root=Bluetooth"];
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
    if (self.isScanning) {
        [self.centralManager stopScan];
        self.isScanning = NO;
        [timer invalidate];
        timer = nil;
    }
}
/*** 对外接口： 停止扫描蓝牙设备 ***/
- (void)stopToScanBluetoothPeripheral
{
    if (self.isScanning) {
        [self.centralManager stopScan];
        self.isScanning = NO;
    }
}


#pragma mark - 连接蓝牙
- (void)connect:(CBPeripheral *)peripheral
{
    if (peripheral.state == CBPeripheralStateDisconnected) {
        [self.centralManager connectPeripheral:peripheral options:nil];
//        NSArray *retrievePeripherals = [self.centralManager retrievePeripheralsWithIdentifiers:@[ECG_SERVICE_UUID]];
        
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
    switch (central.state)
    {
        case CBCentralManagerStateUnknown:         // 未知
            break;
        case CBCentralManagerStateResetting:       // 正在重启
            break;
        case CBCentralManagerStateUnsupported:     // 不支持
            break;
        case CBCentralManagerStateUnauthorized:    // 未授权
            break;
        case CBCentralManagerStatePoweredOff:      // 关闭蓝牙
            break;
        case CBCentralManagerStatePoweredOn:       // 开启蓝牙
            break;
        default:
            break;
    }
    
}

/*** 扫描到蓝牙时调用 ***/
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    // 记录搜索到的外设
    if (![self.allowToConnectPeripherals containsObject:peripheral]) {
        [self.allowToConnectPeripherals addObject:peripheral];
        //NSAssert(self.reloadPeripheralDevices != nil, @"reloadPeripheralDevices invoke is nil");
        // 完成回调
        //self.reloadPeripheralDevices();
        //NSLog(@"%@--%@",peripheral.name , advertisementData[CBAdvertisementDataLocalNameKey]);
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
    // 连接成功后停止扫描
    [self stopToScanBluetoothPeripheral];
    // 记录连接状态
    self.deviceConnecting = YES;
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error
{
    self.deviceConnecting = NO;
}


- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error
{
    self.deviceConnecting = NO;
}

//- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary<NSString *, id> *)dict {
//    
//}


#pragma mark
#pragma mark - CBPeripheralDelegate

/*** 发现服务时调用 ***/
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error
{
    for (CBService *service in peripheral.services)
    {
        if ([service.UUID isEqual:[CBUUID UUIDWithString:ECG_SERVICE_UUID]]) {
            NSLog(@"发现20P的服务: %@", service.UUID);
            [peripheral discoverCharacteristics:nil forService:service];
            
            break;
        }
    }
}

/*** 发现特征时调用 ***/
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error
{
    for (CBCharacteristic *characteristic in service.characteristics) {
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:ECG_CHAR_UUID]]) {
            NSLog(@"发现20P的特征:%@ for service: %@", characteristic.UUID, service.UUID);
            
            self.writeCharacter = characteristic;//保存读的特征
            break;
        }
    }
}





#pragma mark - 十六进制转换为NSData数据流
- (NSData *)convertHexStrToData:(NSString *)str
{
    if (!str || [str length] == 0) {
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
        // CBCentralManagerOptionShowPowerAlertKey: [NSNumber numberWithBool:NO] --> 关闭系统默认的蓝牙关闭提示框
        NSDictionary *option = @{
                                 CBCentralManagerOptionShowPowerAlertKey: [NSNumber numberWithBool:NO],
                                 //CBCentralManagerOptionRestoreIdentifierKey: kMyCBCentralManagerOptionRestoreIdentifierKey
                                 };
        _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:option];
        
#warning 判断是否开启了蓝牙的后台模式
        NSArray *backgroundModes = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"UIBackgroundModes"];
        if ([backgroundModes containsObject:@"bluetooth-central"]) {
            // 后台模式
            NSLog(@"-----开启了蓝牙后台模式");
        } else {
            // 非后台模式
            NSLog(@"-----未开启蓝牙后台模式,请在info.plist中添加UIBackgroundModes字段,并添加:'App communicates using CoreBluetooth'、'App shares data using CoreBluetooth'");
        }
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
