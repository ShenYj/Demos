//
//  ViewController.m
//  DatePickerTest
//
//  Created by ecg on 2017/10/10.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import "ViewController.h"
#import "JSBirthdayView.h"

@interface ViewController ()
{
    UIButton *queRenBtn;
    NSString *pinStr;
    NSString *shiJianPinStr;
}
@property (nonatomic,strong) JSBirthdayView  *datePickerBaseView;
@property (nonatomic,strong) UIDatePicker    *riQidatePicker;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.datePickerBaseView = [[JSBirthdayView alloc] init];
    [self.view addSubview: self.datePickerBaseView];
    [self.datePickerBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.view);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    //背景View
//    UIView *coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
//    [self.view addSubview:coverView];
//
//    self.datePickerBaseView = [[JSBirthdayView alloc] init];
//    [coverView addSubview: self.datePickerBaseView];

//    self.datePickerBaseView = [[UIView alloc] initWithFrame:CGRectMake(114*BXScreenW/414/2, 100*BXScreenW/414, 300*BXScreenW/414, 350*BXScreenH/736)];
//    self.datePickerBaseView.backgroundColor = BXColor(245, 245, 245);
//    [coverView addSubview:self.datePickerBaseView];

//    self.riQidatePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 80*BXScreenH/736, 300*BXScreenW/414, 200*BXScreenH/736)];
//    self.riQidatePicker.datePickerMode = UIDatePickerModeDate;
//    self.riQidatePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//[NSLocale currentLocale];
//    self.riQidatePicker.timeZone = [NSTimeZone localTimeZone];
//
//    [self.datePickerBaseView addSubview:self.riQidatePicker];
    //[riQidatePicker setDate:nowDate animated:YES];
    //属性：datePicker.date当前选中的时间 类型 NSDate
    
//    [self.riQidatePicker addTarget:self action:@selector(dateChange:) forControlEvents: UIControlEventValueChanged];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"yyyy-MM-dd"];
//    pinStr = [formatter stringFromDate:self.riQidatePicker.date];
    
//    UIButton *queXiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    queXiaoBtn.frame = CGRectMake(30*BXScreenW/414, 290*BXScreenH/736, 100*BXScreenW/414, 40*BXScreenH/736);
//    [queXiaoBtn addTarget:self action:@selector(quXiaoBtn) forControlEvents:UIControlEventTouchUpInside];
//    [queXiaoBtn setTitle:@"取消" forState:UIControlStateNormal];
//    [queXiaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    queXiaoBtn.layer.cornerRadius = 5.0;
//    queXiaoBtn.backgroundColor = [UIColor lightGrayColor];
//    [self.datePickerBaseView addSubview:queXiaoBtn];
//    [self createQueRenBtn];
}

#pragma mark-----第一个确认按钮--------------------
- (void)createQueRenBtn{
    queRenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    queRenBtn.frame = CGRectMake(170*ScreenW/414, 290*ScreenH/736, 100*ScreenW/414, 40*ScreenH/736);
//    [queRenBtn addTarget:self action:@selector(riQiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [queRenBtn setTitle:@"确定" forState:UIControlStateNormal];
    queRenBtn.backgroundColor = BXColor(252, 102, 52);
    queRenBtn.layer.cornerRadius = 5.0;
    [queRenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.datePickerBaseView  addSubview:queRenBtn];
    
}
//取消按钮
- (void)quXiaoBtn
{
    [self.datePickerBaseView removeFromSuperview];
}
//- (void)dateChangeShiJian:(UIDatePicker *)senser{
//    //这个NSDateFormatter类用来设计时间的格式  Formatter格式化
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    //设置格式 yyyy表示几几年如2016 yy也是表示年份为16年 MM表示月 dd表示日 a表示上下午 HH表示小时 （24进制 hh表示12进制）mm表示分钟  ss表示秒  eeee表示星期几 eee表示周几 e表示第几天
//    // HH点mm分ss秒  "
//    [formatter setDateFormat:@"HH:mm"];
//    //设置星期几的别称礼拜几 注意顺序 系统是从周日算作第一天的
//    //[formatter setWeekdaySymbols:@[@"礼拜天",@"礼拜一",@"礼拜二",@"礼拜三",@"礼拜四",@"礼拜五",@"礼拜六"]];
//    //设置上午下午别称
//    //[formatter setAMSymbol:@"前晌"];
//    //[formatter setPMSymbol:@"晌午"];
//
//    //根据日期的格式formatter 把NSDate类型转换成NSString类型
//    shiJianPinStr = [formatter stringFromDate:senser.date];
//    NSLog(@"%@",shiJianPinStr);
//    //调出设备当前的时间
//    //NSDate *nowDate = [NSDate date];
//}

//- (void)dateChange:(UIDatePicker *)senser
//{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"yyyy-MM-dd"];
//    pinStr = [formatter stringFromDate:senser.date];
//}



@end
