//
//  DownloadOperation.h
//  多线程-NSOperation
//
//  Created by ShenYj on 16/8/22.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DownloadOperation : NSOperation

// url地址
@property (nonatomic,copy) NSString *urlString;
// 完成回调
@property (nonatomic,copy) void(^completeHandler)(UIImage *img);


@end
