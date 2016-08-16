//
//  UINavigationController+JSFullScreenPopGesture.h
//  test
//
//  Created by ShenYj on 16/8/16.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (JSFullScreenPopGesture)

/// 自定义全屏拖拽返回手势
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *js_popGestureRecognizer;

@end
