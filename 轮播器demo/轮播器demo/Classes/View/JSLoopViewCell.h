//
//  JSLoopViewCell.h
//  轮播器demo
//
//  Created by ShenYj on 2016/10/19.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSLoopViewCell : UICollectionViewCell


/**
 * 轮播器图片资源图片URL字符串
 */
@property (nonatomic) NSString *imageUrlString;

@property (nonatomic) NSInteger currentIndex;

@end
