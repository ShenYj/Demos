//
//  JSProgressAlert.h
//  ProgressAlert
//
//  Created by ecg on 2017/8/24.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSProgressAlert : UIAlertController

/*** 进度条 ***/
@property (nonatomic,strong) UIProgressView  *progressView;
/*** 标题Label ***/
@property (nonatomic,weak) UILabel *titleLabel;
/*** 内容Label ***/
@property (nonatomic,weak) UILabel *messgeLabel;
/*** 背景视图 ***/
@property (nonatomic,weak) UIView  *baseView;

@end
