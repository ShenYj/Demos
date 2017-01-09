//
//  JSLoopView.h
//  轮播器demo
//
//  Created by ShenYj on 2016/10/19.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSLoopView : UICollectionView <UICollectionViewDataSource,UICollectionViewDelegate>

/**
 * 轮播器图片资源数组,存放图片URL字符串
 */
@property (nonatomic) NSArray <NSString *>*imageUrls;

@property (nonatomic,copy) void (^compeletionHandler)(NSInteger idx);

@end
