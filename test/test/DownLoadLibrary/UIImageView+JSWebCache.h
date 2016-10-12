//
//  UIImageView+JSWebCache.h
//  test
//
//  Created by ShenYj on 2016/10/12.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (JSWebCache)

- (void)js_setImageWithUrlString:(NSString *)urlString withPlaceHolderImage:(UIImage *)placeHolderImage;

@end
