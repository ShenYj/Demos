//
//  JSPeripheralInfo.m
//  蓝牙(CoreBluetooth)
//
//  Created by ShenYj on 2017/3/30.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSPeripheralInfo.h"
#import "UIView+JS_Frame.h"

@interface JSPeripheralInfo ()

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *services;
@property (nonatomic,strong) UILabel *serviceUUIDs;

@end

@implementation JSPeripheralInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self preparePeripheralView];
}

- (void)preparePeripheralView {
    self.view.backgroundColor = [UIColor colorWithWhite:206 alpha:1.0];
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.services];
    [self.view addSubview:self.serviceUUIDs];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)setPeripheral:(CBPeripheral *)peripheral {
    _peripheral = peripheral;
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    self.nameLabel.text = peripheral.name;
    self.services.text = peripheral.identifier.UUIDString;
    NSLog(@"%zd -- %@",self.view.subviews.count,NSStringFromCGRect(self.nameLabel.frame));
    
    for (CBService *service in peripheral.services) {
        for (CBCharacteristic *characteristic in service.characteristics) {
            
        }
    }
}

- (void)setAdvertisementData:(NSDictionary<NSString *,id> *)advertisementData {
    _advertisementData = advertisementData;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark
#pragma mark - lazy

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height * 0.2)];
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.textColor = [UIColor blackColor];
    }
    return _nameLabel;
}

- (UILabel *)services {
    if (!_services) {
        _services = [[UILabel alloc] initWithFrame:CGRectMake(0, self.nameLabel.js_height, self.view.bounds.size.width, self.view.bounds.size.height * 0.3)];
        _services.font = [UIFont systemFontOfSize:11];
        _services.textColor = [UIColor blackColor];
        _services.numberOfLines = 0;
    }
    return _services;
}

- (UILabel *)serviceUUIDs {
    if (!_serviceUUIDs) {
        _serviceUUIDs = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height * 0.5, self.view.bounds.size.width, self.view.bounds.size.height * 0.5)];
        _serviceUUIDs.font = [UIFont systemFontOfSize:11];
        _serviceUUIDs.textColor = [UIColor blackColor];
        _serviceUUIDs.numberOfLines = 0;
    }
    return _serviceUUIDs;
}


@end
