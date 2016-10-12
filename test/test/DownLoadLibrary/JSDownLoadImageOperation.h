//
//  JSDownLoadImageOperation.h
//  test
//
//  Created by ShenYj on 2016/10/12.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface JSDownLoadImageOperation : NSOperation

@property (nonatomic,copy) NSString *imageURL;
@property (nonatomic,copy) void (^finishBlock)(UIImage *img);

+ (instancetype)downLoadWithImageUrlString:(NSString *)urlString completionHandler:(void (^)(UIImage *img))completionHandler;

@end
