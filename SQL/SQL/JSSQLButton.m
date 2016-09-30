//
//  JSSQLButton.m
//  SQL
//
//  Created by ShenYj on 16/9/30.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "JSSQLButton.h"

@implementation JSSQLButton
- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 2;
    }
    return self;
}
@end
