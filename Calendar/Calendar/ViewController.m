//
//  ViewController.m
//  Calendar
//
//  Created by ecg on 2017/8/23.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    //[calendar setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    //[calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CCT"]];
    //[calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:+28800]];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *componets = [calendar components:unit fromDate:[NSDate date]];
    
    NSLog(@"%@",componets);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
