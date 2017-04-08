//
//  JSPeripheralInfo.h
//  蓝牙(CoreBluetooth)
//
//  Created by ShenYj on 2017/3/30.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface JSPeripheralInfo : UIViewController

@property (nonatomic,strong) CBPeripheral *peripheral;
@property (nonatomic,strong) NSDictionary<NSString *, id> *advertisementData;

@end
