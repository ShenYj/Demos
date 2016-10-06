//
//  JSPopButton.m
//  PopTest
//
//  Created by ShenYj on 16/10/5.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "JSPopButton.h"

CGFloat const kButtonSize = 80;

@implementation JSPopButton

- (instancetype)initWithName:(NSString *)name {
    
    self = [super init];
    
    if (self) {
        self.bounds = CGRectMake(0, 0, kButtonSize, kButtonSize);
        self.clipsToBounds = YES;
        self.layer.borderWidth = 2;
        [self setTitle:name forState:UIControlStateNormal];
        self.layer.borderColor = [UIColor redColor].CGColor;
        [self setTitle:@"" forState:UIControlStateHighlighted];
        self.layer.cornerRadius = MIN(self.bounds.size.width, self.bounds.size.height) * 0.5;
        [self addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self setBackgroundColor:[UIColor greenColor]];
        
    }
    return self;
}

- (void)clickButton:(UIButton *)sender {
    
    
    NSLog(@"%s",__func__);
}

@end
