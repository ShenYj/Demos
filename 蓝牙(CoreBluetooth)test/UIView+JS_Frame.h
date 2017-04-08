//
//  UIView+JS_Frame.h
//  蓝牙(CoreBluetooth)
//
//  Created by ShenYj on 2017/3/30.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JS_Frame)

/** x轴坐标 */
@property (nonatomic,assign) CGFloat js_cooridinateX;
/** Y轴坐标 */
@property (nonatomic,assign) CGFloat js_cooridinateY;
/** 宽 */
@property (nonatomic,assign) CGFloat js_width;
/** 高 */
@property (nonatomic,assign) CGFloat js_height;
/** size */
@property (nonatomic,assign) CGSize js_size;
/** 中心X坐标 */
@property (nonatomic,assign) CGFloat js_centerX;
/** 中心Y坐标 */
@property (nonatomic,assign) CGFloat js_centerY;


@end
