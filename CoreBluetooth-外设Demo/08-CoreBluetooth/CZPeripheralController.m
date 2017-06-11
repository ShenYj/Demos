//
//  CZPeripheralController.m
//  08-CoreBluetooth
//
//  Created by zzz on 16/7/14.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "CZPeripheralController.h"
#import <CoreBluetooth/CoreBluetooth.h>

//服务UUID
static NSString * const kServiceUUID = @"7E57";
//外设名称
static NSString * const kPeripheralName = @"传智外设";
//特征UUID
static NSString * const kCharacteristicUUID = @"B71E";

@interface CZPeripheralController ()<CBPeripheralManagerDelegate>

//外设管理者
@property (nonatomic, strong) CBPeripheralManager *pmgr;
//开始广播按钮
@property (weak, nonatomic) IBOutlet UIButton *startAdvBtn;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation CZPeripheralController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.startAdvBtn.enabled = NO;
    self.pmgr = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
}

//点击开始广播按钮
- (IBAction)clickStartAdvBtn:(id)sender {
    //设置参数
    //设置外设名称
    NSString *peripheralName = kPeripheralName;
    //设置服务UUID
    CBUUID *serviceUUID = [CBUUID UUIDWithString:kServiceUUID];
    NSDictionary *advDict = @{
                              CBAdvertisementDataLocalNameKey: peripheralName,
                              CBAdvertisementDataServiceUUIDsKey:@[serviceUUID]
                              };
    //开始广播
    [self.pmgr startAdvertising:advDict];
}

#pragma mark - CBPeripheralManagerDelegate

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    //判断外设的蓝牙状态是否为开启
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        self.startAdvBtn.enabled = YES;
        //初始化服务&特征
        [self setupService];
    }
}

//设置服务
- (void)setupService{
    //创建服务
    CBMutableService *service = [[CBMutableService alloc]
                    initWithType:[CBUUID UUIDWithString:kServiceUUID] primary:YES];
    //设置特征
    CBMutableCharacteristic *characteristic = [[CBMutableCharacteristic alloc] initWithType:[CBUUID UUIDWithString:kCharacteristicUUID] properties:CBCharacteristicPropertyWrite | CBCharacteristicPropertyRead value:nil permissions:CBAttributePermissionsReadable | CBAttributePermissionsWriteable];
    //添加特征
    service.characteristics = @[characteristic];
    //添加服务
    [self.pmgr addService:service];
}

//当已经接收读取数据的请求后调用
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request{
    
    NSString *str = @"你好,我是外设";
    //把数据写入特征
    [request setValue:[str dataUsingEncoding:NSUTF8StringEncoding]];
    //告诉中心,外设接收请求成功
     [self.pmgr respondToRequest:request withResult:CBATTErrorSuccess];
}

//当已经接收写入数据的请求后调用
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray<CBATTRequest *> *)requests{
    
    CBATTRequest *request = requests.lastObject;
    //需要转换成CBMutableCharacteristic对象才能进行写值
    CBMutableCharacteristic *characteristic =(CBMutableCharacteristic *)request.characteristic;
    //将中央传递的数据给外设的特征
    characteristic.value = request.value;
    //接收到请求的响应
    [self.pmgr respondToRequest:request withResult:CBATTErrorSuccess];
    
    NSString *str = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    self.contentLabel.text = str;
    NSLog(@"%@", str);
}


@end
