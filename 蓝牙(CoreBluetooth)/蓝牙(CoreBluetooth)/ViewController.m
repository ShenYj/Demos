//
//  ViewController.m
//  蓝牙(CoreBluetooth)
//
//  Created by ShenYj on 2017/3/29.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController () <CBCentralManagerDelegate>

/** 中央管理者,我们iPhone设备自身 */
@property (nonatomic,strong) CBCentralManager *centralManager;

/** 开始扫描外设按钮 */
@property (weak, nonatomic) IBOutlet UIButton *startToScan;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 开始扫描外设按钮点击事件
    [self.startToScan addTarget:self action:@selector(clickStartToScanButton:) forControlEvents:UIControlEventTouchUpInside];
    // 默认开始扫描按钮状态设置为No;当检测到设备支持并开启蓝牙后才允许按钮的交互
    self.startToScan.enabled = NO;
    
    // 1. 创建中央管理者(我们iPhone自身蓝牙管理者)
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:0];
    
}

- (void)clickStartToScanButton:(UIButton *)sender {
    // 2. 扫描外设
    NSArray *serviceUUIDs = nil; // 设置为nil代表无差别扫描/扫描所有外设,不限制UUID
    /*
     CBCentralManagerScanOptionAllowDuplicatesKey
     CBCentralManagerScanOptionSolicitedServiceUUIDsKey
     */
    [self.centralManager scanForPeripheralsWithServices:serviceUUIDs options:nil];
    // 3. 连接外设
    
    // 4. 查找服务
    
    // 5. 查找特征
    
    // 6. 读写数据
}

#pragma mark 
#pragma mark - CBCentralManagerDelegate
/**
 * 中央管理者已经更新状态后调用
 *
 * @param central 中央管理者
 */
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    // 判断状态
    switch (central.state) {
        case CBManagerStateUnknown:         // 未知
        case CBManagerStateResetting:       // 正在重启
        case CBManagerStateUnsupported:     // 不支持
        case CBManagerStateUnauthorized:    // 未授权
        case CBManagerStatePoweredOff:      // 关闭蓝牙
            self.startToScan.enabled = NO;
            break;
        case CBManagerStatePoweredOn:       // 开启蓝牙
            self.startToScan.enabled = YES;
            break;
        default:
            break;
    }
}

/** 
 * 发现某个外设后调用
 *
 * @param central 中央管理者
 * @param peripheral 外设
 * @param advertisementData 广播数据
 * @param RSSI 信号强度 分贝
 */

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
    // 获取外设名称
    NSString *peripheralName = advertisementData[CBAdvertisementDataLocalNameKey];
    NSLog(@"%@",peripheralName);
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
