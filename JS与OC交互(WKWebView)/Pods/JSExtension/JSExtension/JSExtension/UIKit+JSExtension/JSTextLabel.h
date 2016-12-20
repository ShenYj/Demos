//
//  JSTextLabel.h
//  Weibo_Object-C
//
//  Created by ShenYj on 2016/11/25.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JSTextLabel;

@protocol JSTextLabelDelegate <NSObject>
@optional
- (void)textLabel:(JSTextLabel *)textLabel withClickTextStorageString:(NSString *)string;
@end

@interface JSTextLabel : UILabel

@property (nonatomic,weak) id <JSTextLabelDelegate> delegate;

@end
