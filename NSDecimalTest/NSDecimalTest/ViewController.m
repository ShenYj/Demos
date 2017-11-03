//
//  ViewController.m
//  NSDecimalTest
//
//  Created by ShenYj on 2017/6/28.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    double price = 0.1;
//    NSDecimalNumber *decimalNumber1 = [NSDecimalNumber decimalNumberWithMantissa:price exponent:2 isNegative:NO];
//    NSLog(@"%@",decimalNumber1);   --> 0
    
    
    CGFloat price = 0.001;
    NSNumber *price_float = [NSNumber numberWithFloat:price];
    NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithDecimal:price_float.decimalValue];
    NSDecimalNumber *total_price = [decimalNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithMantissa:100 exponent:0 isNegative:NO]];
    NSLog(@"%@",total_price);
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
