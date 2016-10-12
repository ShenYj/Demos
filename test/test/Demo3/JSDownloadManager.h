//
//  JSDownloadManager.h
//  test
//
//  Created by ShenYj on 2016/10/12.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JSDownloadManager : NSObject

// 获取单例
+ (instancetype)sharedManager;

// 下载图片
- (void)downLoadWithImageUrlString:(NSString *)urlString completionHandler:(void (^)(UIImage *img))completionHandler;

// 取消操作
- (void)cancelOperationWithUrlString:(NSString *)urlString;

@end
