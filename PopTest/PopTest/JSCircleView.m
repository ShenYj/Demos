//
//  JSCircleView.m
//  PopTest
//
//  Created by ShenYj on 16/10/6.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "JSCircleView.h"

@implementation JSCircleView


// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:self.center radius:100 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    
    [bezierPath stroke];
    
    
}


@end
