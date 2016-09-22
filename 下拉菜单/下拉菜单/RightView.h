//
//  RightView.h
//  下拉菜单
//
//  Created by ShenYj on 16/9/22.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RightViewButtonType) {
    RightViewButtonTypeUserName,
    RightViewButtonTypePassWord
};

@interface RightView : UIView

@property (nonatomic,copy) NSString *imageName;
@property (nonatomic,copy) NSString *imageNameSel;
@property (nonatomic,assign) RightViewButtonType buttonType;
@property (nonatomic,copy) void (^handler)();

@end
