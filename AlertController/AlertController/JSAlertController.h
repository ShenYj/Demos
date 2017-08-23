//
//  JSAlertController.h
//  AlertController
//
//  Created by ecg on 2017/8/23.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSAlertController : UIAlertController

/*** 标题Label ***/
@property (nonatomic,weak) UILabel *titleLabel;
/*** 内容Label ***/
@property (nonatomic,weak) UILabel *messgeLabel;

@end
