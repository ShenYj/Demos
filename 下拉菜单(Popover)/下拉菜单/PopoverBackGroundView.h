//
//  PopoverBackGroundView.h
//  下拉菜单
//
//  Created by ShenYj on 16/9/22.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface PopoverBackGroundView : UIPopoverBackgroundView

//@property (nonatomic, readwrite) CGFloat arrowOffset;
//
//@property (nonatomic, readwrite) UIPopoverArrowDirection arrowDirection;
//
//@property(class, nonatomic, readonly) BOOL wantsDefaultContentAppearance;
@property (nonatomic,strong) UIImageView *arrowImageView;

- (UIImage *)drawArrowImage:(CGSize)size;

@end
