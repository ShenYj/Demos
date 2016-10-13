//
//  ViewController.m
//  NSDate练习
//
//  Created by ShenYj on 2016/10/13.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
#pragma mark 
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:- 60 * 60 * 24 * 7];
    
    NSDate *date2 = [NSDate dateWithTimeIntervalSinceNow:- 60 * 60 * 24 * 8];
    
    if ([[date laterDate:date2] isEqualToDate:date]) {
        
        NSLog(@"%@",date);
        
    }
    
    
    
#pragma mark
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger dateMinute = [calendar component:NSCalendarUnitMinute fromDate:[NSDate date]];
    CGFloat minute = (CGFloat)dateMinute;
    
    NSLog(@"%f",minute);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
