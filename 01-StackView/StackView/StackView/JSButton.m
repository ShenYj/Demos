//
//  JSButton.m
//  StackView
//
//  Created by ShenYj on 16/8/2.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSButton.h"

@implementation JSButton


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return self;
}


@end
