//
//  UIImageView+JSWebCache.m
//  test
//
//  Created by ShenYj on 2016/10/12.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "UIImageView+JSWebCache.h"
#import "JSDownloadManager.h"
#import <objc/runtime.h>

const char * flag = "abc";

@interface UIImageView ()

@property (nonatomic,copy) NSString *currentString;

@end

@implementation UIImageView (JSWebCache)

- (void)js_setImageWithUrlString:(NSString *)urlString withPlaceHolderImage:(UIImage *)placeHolderImage {
    
    // 设置占位图
    self.image = placeHolderImage;
    
    //cell.imageView.image = [UIImage imageNamed:@"user_default.png"];
    
    if (![self.currentString isEqualToString:urlString]) {
        [[JSDownloadManager sharedManager] cancelOperationWithUrlString:self.currentString];
    }
    
    self.currentString = urlString;
    
    __weak typeof(self) weakSelf = self;
    [[JSDownloadManager sharedManager] downLoadWithImageUrlString:urlString completionHandler:^(UIImage *img) {
        
        // 设置图片
        weakSelf.image = img;
        
    }];
    
}

- (void)setCurrentString:(NSString *)currentString {
    
    objc_setAssociatedObject(self, flag, currentString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)currentString {
    
    return objc_getAssociatedObject(self, flag);
}

@end
