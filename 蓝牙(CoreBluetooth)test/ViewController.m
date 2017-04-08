//
//  ViewController.m
//  蓝牙(CoreBluetooth) 手机作为中央端设备
//
//  Created by ShenYj on 2017/3/29.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "ViewController.h"
#import "JSPeripheralInfo.h"
#import <CoreBluetooth/CoreBluetooth.h>

// 和做蓝牙设备的同事约定好UUID
#define TRANSFER_SERVICE_UUID           @"0000fff0-0000-1000-8000-00805f9b34fb"
#define TRANSFER_CHARACTERISTIC_UUID    @"0000fff7-0000-1000-8000-00805f9b34fb"

#define SCREEN_BOUNDS_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_BOUNDS_HEIGTH [UIScreen mainScreen].bounds.size.height
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds

static NSString * const kReusedIdentifier = @"kReusedIdentifier";


@interface ViewController () <CBCentralManagerDelegate,CBPeripheralDelegate,UITableViewDataSource,UITableViewDelegate,UIPopoverPresentationControllerDelegate>

/** 中央管理者,我们iPhone设备自身 */
@property (nonatomic,strong) CBCentralManager *centralManager;
/** 外设(记录连接的外设) */
@property (nonatomic,strong) CBPeripheral *peripheral;
/** 开始扫描外设按钮 */
@property (weak, nonatomic) IBOutlet UIButton *startToScan;
@property (weak, nonatomic) IBOutlet UIButton *stopToScan;
/** 存储搜索到的周边外设 */
@property (nonatomic,strong) NSMutableArray *allowToConnectPeripherals;
@property (nonatomic,strong) UITableView *peripheralList;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.peripheralList registerClass:[UITableViewCell class] forCellReuseIdentifier:kReusedIdentifier];
    [self.view addSubview:self.peripheralList];
    // 开始/停止 扫描外设按钮点击事件
    [self.startToScan addTarget:self action:@selector(clickStartToScanButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.stopToScan addTarget:self action:@selector(clickStopToScanButton:) forControlEvents:UIControlEventTouchUpInside];
    // 默认开始扫描按钮状态设置为No;当检测到设备支持并开启蓝牙后才允许按钮的交互
    self.startToScan.enabled = NO;
    
    // 1. 创建中央管理者(我们iPhone自身蓝牙管理者)
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:0];
    
}

- (void)clickStartToScanButton:(UIButton *)sender {
    if (!sender.isSelected) {
        sender.selected = YES;
        // 2. 扫描外设
        NSArray *serviceUUIDs = nil; // 设置为nil代表无差别扫描/扫描所有外设,不限制UUID
        /*
         CBCentralManagerScanOptionAllowDuplicatesKey
         CBCentralManagerScanOptionSolicitedServiceUUIDsKey
         提示。
         */
        // 根据标识获取可重连的设备
        //NSArray<CBPeripheral *>*retrievePeripherals = [self.centralManager retrieveConnectedPeripheralsWithServices:@[TRANSFER_SERVICE_UUID]];
        [self.centralManager scanForPeripheralsWithServices:serviceUUIDs options:nil];
    }
}

- (void)clickStopToScanButton:(UIButton *)sender {
    if (self.startToScan.isSelected) {
        [self.centralManager stopScan];
        self.startToScan.selected = NO;
    }
}

#pragma mark 
#pragma mark - CBCentralManagerDelegate
/**
 * 中央管理者已经更新状态后调用
 *
 * @param central   中央管理者
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
 * @param central           中央管理者
 * @param peripheral        外设
 * @param advertisementData 广播数据
 * @param RSSI              信号强度 分贝
 */
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
    // 获取外设名称
    /* 搜索到外设的其他参数
     NSString *peripheralName = advertisementData[CBAdvertisementDataLocalNameKey];
     NSString *txPowerLevel = advertisementData[CBAdvertisementDataTxPowerLevelKey];
     NSDictionary *dataSeviceUUIDs = advertisementData[CBAdvertisementDataServiceUUIDsKey];
     NSArray *dataSeviceData = advertisementData[CBAdvertisementDataServiceDataKey];
     NSArray *dataManuFactureData = advertisementData[CBAdvertisementDataManufacturerDataKey];
     NSNumber *dataOverflowServiceUUIDs = advertisementData[CBAdvertisementDataOverflowServiceUUIDsKey];
     BOOL dataIsConnectable = advertisementData[CBAdvertisementDataIsConnectable];
     NSArray *dataSolicitedServiceUUIDs = advertisementData[CBAdvertisementDataSolicitedServiceUUIDsKey];
     NSLog(@"发现设备:%@ - %@",peripheralName,peripheral.name);
     NSLog(@"发现外设: -> %@ - %@",advertisementData,peripheral.name);
    */
    // 存储搜索到的外设
    if (![self.allowToConnectPeripherals containsObject:peripheral]) {
        [self.allowToConnectPeripherals addObject:peripheral];
        [self.peripheralList reloadData];
        NSLog(@"%@",self.allowToConnectPeripherals);
    }
    
    /*
         CBConnectPeripheralOptionNotifyOnConnectionKey —— 在连接成功后，程序被挂起， 给出系统提示。
         CBConnectPeripheralOptionNotifyOnDisconnectionKey —— 在程序挂起，蓝牙连接断开时，给出系统提示。
         CBConnectPeripheralOptionNotifyOnNotificationKey —— 在程序挂起后，收到 peripheral 数据时，给出系统
     */
    // 3. 连接外设
    /*
    if ([peripheralName isEqualToString:@"BR508767"]) {
        [self.centralManager stopScan];

        [self.centralManager connectPeripheral:peripheral options:@ {CBConnectPeripheralOptionNotifyOnConnectionKey: @YES,
                                                                     CBConnectPeripheralOptionNotifyOnDisconnectionKey: @YES,
                                                                     CBConnectPeripheralOptionNotifyOnNotificationKey: @YES
                                                                     }];
        self.peripheral = peripheral;
    }
     */
    /*
    if ([peripheralName isEqualToString:@"ShenYj的MacBook Pro"] || [peripheral.name isEqualToString:@"ShenYj的MacBook Pro"]) {
        // 在查找到需要的设备后停止扫描外设
        [self.centralManager stopScan];
        [self.centralManager connectPeripheral:peripheral options:nil];
        // 记录外设 (强引用,防止销毁)
        self.peripheral = peripheral;
    }
    */
}

/**
 * 已经连接到外设后调用
 *
 * @param central       中央管理者
 * @param peripheral    外设
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"连接外设成功");
    
    // 4. 查找服务 (参数为nil代表查找所有服务)
    [peripheral discoverServices:nil];
    // 获取数据,设置外设的代理
    peripheral.delegate = self;
}
/** 断开连接 */
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    NSLog(@"断开连接:%s-%@",__func__,error);
    // 连接断开后重连
    [self clickStartToScanButton:self.startToScan];
}
/** 连接外设失败后调用 */
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    NSLog(@"连接外设失败: %@",error);
}

#pragma mark
#pragma mark - CBPeripheralDelegate
/** 
 * 查找到服务后调用
 *
 * @param peripheral 外设
 * @param error      错误信息
 **/
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error {
    NSLog(@"查找到服务: %@",peripheral.services);
    // 遍历外设中的服务
    for (CBService *service in peripheral.services) {
        if ( [service.UUID.UUIDString isEqualToString:@"FFA0"] ) {
            // 5. 查找特征 (可通过查找到的特征UUID匹配是否是我们需要查找的特征)
            NSLog(@"%@",service);
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
}
/**
 * 查找到特征后调用
 *
 * @param peripheral 外设
 * @param service    服务
 * @param error      错误信息
 **/
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error {
    // 6. 读通过特征读写数据
    NSLog(@"查找到特征:%@",service.characteristics);
    for (CBCharacteristic *characteristic in service.characteristics) {
        if ([characteristic.UUID.UUIDString isEqualToString:@""]) {
            // 6.1 读取数据
            [peripheral readValueForCharacteristic:characteristic];
            
        }
    }
}
/** 
 * 读取特征中的数据后调用
 *
 * @param peripheral        外设
 * @param characteristic    特征
 * @param error             错误信息
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    // 6.1 读取到的数据
    NSData *dataR = characteristic.value;
    NSLog(@"%@",[[NSString alloc] initWithData:dataR encoding:NSUTF8StringEncoding]);
    
    // 6.2 写数据
    NSData *dataW = [@"demo" dataUsingEncoding:NSUTF8StringEncoding];
    // CBCharacteristicWriteWithResponse 发送后会有结果响应
    [peripheral writeValue:dataW forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
}
/**
 * 写入数据后调用
 *
 * @param peripheral        外设
 * @param characteristic    特征
 * @param error             错误信息
 */
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    NSLog(@"已经发送");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark - table view dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allowToConnectPeripherals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusedIdentifier forIndexPath:indexPath];
    CBPeripheral *peripheral = self.allowToConnectPeripherals[indexPath.row];
    cell.textLabel.text = peripheral.name;
    return cell;
}

#pragma mark
#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JSPeripheralInfo *peripheralInfoVC = [[JSPeripheralInfo alloc] init];
    peripheralInfoVC.peripheral = self.allowToConnectPeripherals[indexPath.row];
//    peripheralInfoVC.advertisementData = 
    peripheralInfoVC.modalPresentationStyle = UIModalPresentationPopover;
    peripheralInfoVC.preferredContentSize = CGSizeMake(SCREEN_BOUNDS_WIDTH * 0.5, 300);
    UIPopoverPresentationController *popover = peripheralInfoVC.popoverPresentationController;
    popover.delegate = self;
    UITableViewCell *currentCell = [tableView cellForRowAtIndexPath:indexPath];
    popover.sourceView = currentCell.contentView;
    popover.sourceRect = currentCell.contentView.bounds;
    popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
    popover.canOverlapSourceViewRect = NO;
    [self presentViewController:peripheralInfoVC animated:YES completion:nil];
}

#pragma mark
#pragma mark - UIAdaptivePresentationControllerDelegate
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

#pragma mark 
#pragma mark - lazy
- (NSMutableArray *)allowToConnectPeripherals {
    if (!_allowToConnectPeripherals) {
        _allowToConnectPeripherals = [NSMutableArray array];
    }
    return _allowToConnectPeripherals;
}

- (UITableView *)peripheralList {
    if (!_peripheralList) {
        _peripheralList = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_BOUNDS_HEIGTH, SCREEN_BOUNDS_HEIGTH - 200) style:UITableViewStylePlain];
        _peripheralList.dataSource = self;
        _peripheralList.delegate = self;
    }
    return _peripheralList;
}


@end
