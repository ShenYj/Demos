//
//  TableViewCell.m
//  TableView内嵌ScrollView测试
//
//  Created by ShenYj on 2017/2/23.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL isInside = [super pointInside:point withEvent:event];
    for (UIView *subView in self.subviews.reverseObjectEnumerator) {
        // 获取Cell中的ContentView
        if ([subView isKindOfClass:NSClassFromString(@"UITableViewCellContentView")]) {
            
            for (UIView *sSubView in subView.subviews.reverseObjectEnumerator) {
                // 获取ContentView中的Button子视图
                if ([sSubView isKindOfClass:[UIButton class]]) {
                    // point是否在子视图Button之上
                    BOOL isInSubBtnView = CGRectContainsPoint(sSubView.frame, point);
                    // 子视图Button的交互功能是否禁用
                    BOOL isButtonUserInteractionDisabled = sSubView.userInteractionEnabled ? NO : YES;
                    
                    isInside = isInSubBtnView && isButtonUserInteractionDisabled ? NO : YES;
                }

            }
        }
    }
    return isInside;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
