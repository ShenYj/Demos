//
//  ViewController.m
//  默认地图导航-iOS10
//
//  Created by ShenYj on 2017/2/9.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *destination_TF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)clickDirectionBtn:(UIButton *)sender {
    // 获取起点
    MKMapItem *currentMapItem = [MKMapItem mapItemForCurrentLocation];
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder geocodeAddressString:self.destination_TF.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placeMark = placemarks.lastObject;
        MKPlacemark *mkPlaceMark = [[MKPlacemark alloc] initWithPlacemark:placeMark];
        // 获取终点
        MKMapItem *destionMapItem = [[MKMapItem alloc] initWithPlacemark:mkPlaceMark];
        // 通过内置地图进行导航
        [MKMapItem openMapsWithItems:@[currentMapItem,destionMapItem] launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDefault}];
        /*
             ' MKLaunchOptionsDirectionsModeDefault 'Will pick the best directions mode, given the user's preferences
         */
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
