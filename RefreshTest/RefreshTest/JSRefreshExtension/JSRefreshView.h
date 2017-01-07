//
//  JSRefreshView.h
//  JSRefresh_Extension
//
//  Created by ShenYj on 2016/12/6.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

/**
    负责自定义刷新控件的视图界面展示
 */
#import <UIKit/UIKit.h>

/** 刷新状态 */
typedef NS_ENUM(NSUInteger, JSRefreshStatus) {
    JSRefreshStatusNormal,
    JSRefreshStatusPulling,
    JSRefreshStatusWillRefresh,
};

@interface JSRefreshView : UIView
/** 刷新控件的状态 */
@property (nonatomic,assign) JSRefreshStatus refreshStatus;

@end
