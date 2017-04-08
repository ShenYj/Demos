//
//  ViewController.m
//  后台运行
//
//  Created by ShenYj on 2017/4/7.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(log) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    
    BOOL backgroundAccepted = [[UIApplication sharedApplication] setKeepAliveTimeout:600 handler:^{
        [self log];
    }];
    
//    if (backgroundAccepted) {
//        NSLog(@"---------------start new alive------------------");
//    }
    
//    __block UIBackgroundTaskIdentifier backgroundTaskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
//        
//    }];
    
}

- (void)log {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    
    NSLog(@"--> I'm alive! (%@)",[dateFormatter stringFromDate:date]);
    
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
