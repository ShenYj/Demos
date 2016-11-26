//
//  JSTextLabel.m
//  Weibo_Object-C
//
//  Created by ShenYj on 2016/11/25.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSTextLabel.h"


@interface JSTextLabel ()

/** 属性文本存储 NSMutableAttributeString的子类 */
@property (nonatomic,strong) NSTextStorage *textStorage;
/** 负责文本'字形'布局 */
@property (nonatomic,strong) NSLayoutManager *textLayoutManager;
/** 负责文本绘制的范围 */
@property (nonatomic,strong) NSTextContainer *textLayoutContainer;

@end

@implementation JSTextLabel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self prepareTextSystem];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 指定绘制文本区域
    self.textLayoutContainer.size = self.bounds.size;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:rect];
    NSRange range = NSMakeRange(0, self.textStorage.length);
    // Glyphs字形
    [self.textLayoutManager setLocation:CGPointZero forStartOfGlyphRange:range];
}

/** 准备文本系统 */
- (void)prepareTextSystem {
    // 准备文本内容
    [self prepareTextContent];
    // 设置对象的关系
    [self.textStorage addLayoutManager:self.textLayoutManager];
    [self.textLayoutManager addTextContainer:self.textLayoutContainer];
}

/** 准备文本内容 */
- (void)prepareTextContent {    
    if (self.attributedText.length) {
        [self.textStorage setAttributedString:self.attributedText];
    } else if (self.text.length) {
        [self.textStorage setAttributedString:[[NSAttributedString alloc] initWithString:self.text]];
    } else {
        [self.textStorage setAttributedString:[[NSAttributedString alloc] init]];
    }
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self.textStorage setAttributedString:[[NSAttributedString alloc] initWithString:self.text]];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self.textStorage setAttributedString:self.attributedText];
}


#pragma mark 
#pragma mark - Lazy
- (NSTextStorage *)textStorage {
    if (!_textStorage) {
        _textStorage = [[NSTextStorage alloc] init];
    }
    return _textStorage;
}

- (NSLayoutManager *)textLayoutManager {
    if (!_textLayoutManager) {
        _textLayoutManager = [[NSLayoutManager alloc] init];
    }
    return _textLayoutManager;
}

- (NSTextContainer *)textLayoutContainer {
    if (!_textLayoutContainer) {
        _textLayoutContainer = [[NSTextContainer alloc] init];
    }
    return _textLayoutContainer;
}

@end
