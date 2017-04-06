//
//  demoViewController.m
//  蓝牙(CoreBluetooth)
//
//  Created by ecg on 2017/4/6.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "demoViewController.h"
#import "BluetoothManager.h"
#import "JSPeripheralInfo.h"

#define SCREEN_BOUNDS_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_BOUNDS_HEIGTH [UIScreen mainScreen].bounds.size.height
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds

/*** 超时时间 ***/
static int const kTimeOut = 60;
static NSString * const kReusedIdentifier = @"kReusedIdentifier";


@interface demoViewController () <UITableViewDataSource,UITableViewDelegate,UIPopoverPresentationControllerDelegate,JSBluetoothToolDelegate>
/*** 表格：展示搜索到的周边的蓝牙设备 ***/
@property (nonatomic,strong) UITableView *peripheralList;
/*** 容器：记录搜索到的周边的蓝牙设备 ***/
@property (nonatomic,strong) NSArray *periphralDevices;

@end

@implementation demoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.peripheralList registerClass:[UITableViewCell class] forCellReuseIdentifier:kReusedIdentifier];
    [self.view addSubview:self.peripheralList];
    
    // 设置代理
    [BluetoothManager sharedCentralBluetoothManager].delegate = self;
}


- (IBAction)startToScanBluetoothPeripheral:(UIButton *)sender
{
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @0} completionHandler:nil];
    [[BluetoothManager sharedCentralBluetoothManager] scanBluetoothWith:kTimeOut];
}
- (IBAction)stopToScanBluetoothPeripheral:(UIButton *)sender
{
    // 停止扫描蓝牙设备
    [[BluetoothManager sharedCentralBluetoothManager] stopToScanBluetoothPeripheral];
    
}


#pragma mark
#pragma mark - table view dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.periphralDevices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusedIdentifier forIndexPath:indexPath];
    CBPeripheral *peripheral = self.periphralDevices[indexPath.row];
    cell.textLabel.text = peripheral.name;
    return cell;
}

#pragma mark
#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JSPeripheralInfo *peripheralInfoVC = [[JSPeripheralInfo alloc] init];
    peripheralInfoVC.peripheral = self.periphralDevices[indexPath.row];
    //peripheralInfoVC.advertisementData =
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
#pragma mark - JSBluetoothToolDelegate

- (void)js_peripheralFounded:(NSArray<CBPeripheral *> *)peripherals
{
    self.periphralDevices = peripherals;
    [self.peripheralList reloadData];
}

#pragma mark
#pragma mark - lazy

- (UITableView *)peripheralList {
    if (!_peripheralList) {
        _peripheralList = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_BOUNDS_HEIGTH, SCREEN_BOUNDS_HEIGTH - 200) style:UITableViewStylePlain];
        _peripheralList.dataSource = self;
        _peripheralList.delegate = self;
    }
    return _peripheralList;
}

@end
