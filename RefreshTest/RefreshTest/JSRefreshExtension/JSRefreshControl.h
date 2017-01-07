//
//  JSRefresh.h
//  JSRefresh_Extension
//
//  Created by ShenYj on 2016/12/6.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface JSRefreshControl : UIControl

/** 开始刷新,仅修改了刷新视图,实际上并不会发送事件,在界面刚展现时,首次请求数据,调用此方法展示刷新界面,事件由监听父视图的ContentOffset来处理 */
- (void)beginRefresh;
/** 结束刷新 */
- (void)endRefresh;

@end
