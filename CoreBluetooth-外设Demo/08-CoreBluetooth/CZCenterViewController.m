//
//  CZCenterViewController.m
//  08-CoreBluetooth
//
//  Created by zzz on 16/7/14.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "CZCenterViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface CZCenterViewController ()<CBCentralManagerDelegate, CBPeripheralDelegate>
//中央管理者
@property (nonatomic, strong) CBCentralManager *cmgr;
@property (weak, nonatomic) IBOutlet UIButton *startConnectBtn;
//外设
@property (nonatomic, strong) CBPeripheral *peripheral;

@end

@implementation CZCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.startConnectBtn.enabled = NO;
    self.cmgr = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

//点击开始连接按钮
- (IBAction)clickStartConnectBtn:(id)sender {
    //扫描外设
    [self.cmgr scanForPeripheralsWithServices:nil options:nil];
}



#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    
    if (central.state == CBCentralManagerStatePoweredOn) {
        
        self.startConnectBtn.enabled = YES;
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{

    if ([advertisementData[CBAdvertisementDataLocalNameKey] isEqualToString:@"传智外设"]) {
        NSLog(@"发现外设");
        //连接外设
        [self.cmgr connectPeripheral:peripheral options:nil];
        self.peripheral = peripheral;
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"连接外设成功");
    //查询服务
    [peripheral discoverServices:nil];
    //设置代理
    peripheral.delegate = self;
}

#pragma mark - CBPeripheralDelegate

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    NSLog(@"发现服务");
    for (CBService *service in peripheral.services) {
        if ([service.UUID.UUIDString isEqualToString: @"7E57"]) {
            NSLog(@"找到服务");
            //查询特征
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    
    NSLog(@"发现特征");
    for (CBCharacteristic *characteristic in service.characteristics) {
        if ([characteristic.UUID.UUIDString isEqualToString:@"B71E"]) {
            NSLog(@"找到特征");
            //读取数据
            [peripheral readValueForCharacteristic:characteristic];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    //获取数据
    NSData *data = characteristic.value;
    NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    
    NSString *str = @"你好,我是中心";
    //发送数据
    [peripheral writeValue:[str dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
}





@end
