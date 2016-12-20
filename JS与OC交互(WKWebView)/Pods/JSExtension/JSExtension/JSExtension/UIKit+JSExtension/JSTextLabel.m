//
//  JSTextLabel.m
//  Weibo_Object-C
//
//  Created by ShenYj on 2016/11/25.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSTextLabel.h"


@interface JSTextLabel ()

/** 属性文本存储 NSMutableAttributeString的子类(里面存的是要管理的文本) */
@property (nonatomic,strong) NSTextStorage *textStorage;
/** 负责文本'字形'布局(管理文本布局方式) */
@property (nonatomic,strong) NSLayoutManager *textLayoutManager;
/** 负责文本绘制的范围(表示文本要填充的区域) */
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 获取点击的点
    CGPoint locationPoint = [touches.anyObject locationInView:self];
    // 获取当前点击字符的索引
    NSUInteger index = [self.textLayoutManager glyphIndexForPoint:locationPoint inTextContainer:self.textLayoutContainer];
    // 判断点击字符索引是否在存放URLRange的数组内
    for (NSValue *value in [self getUrlsRanges]) {
        NSRange range = value.rangeValue;
        BOOL isInURLRange = NSLocationInRange(index, range);
        if (isInURLRange) {
            // 高亮处理
            [self.textStorage addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:range];
            // 重绘
            [self setNeedsDisplay];
            // 点击range内包含的完整URL
            NSString *string = [self.textStorage.string substringWithRange:range];
            if ([self.delegate respondsToSelector:@selector(textLabel:withClickTextStorageString:)]) {
                [self.delegate textLabel:self withClickTextStorageString:string];
            }
        }
    }
    // @符号处理
    for (NSValue *value in [self getAtRanges]) {
        NSRange range = value.rangeValue;
        BOOL isInAtRange = NSLocationInRange(index, range);
        if (isInAtRange) {
            [self.textStorage addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
            [self setNeedsDisplay];
        }
    }
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self prepareTextContent];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self prepareTextContent];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self prepareTextContent];
}

- (void)setTextColor:(UIColor *)textColor {
    [super setTextColor:textColor];
    [self prepareTextContent];
}

/** 重写绘制文本方法 */
- (void)drawTextInRect:(CGRect)rect {
    //[super drawTextInRect:rect];
    NSRange range = NSMakeRange(0, self.textStorage.length);
    // 绘制背景 在iOS中绘制工作是类似于油画似的,后悔值的内容,会把之前绘制的内容覆盖,所以需要先绘制背景,再绘制字形
    // ps: 当然如果想要先绘制字形,再绘制背景,可以通过设置背景色的透明度来实现,但是因为涉及到透明度,图层混合模式计算,效率较低,消耗性能
    [self.textLayoutManager drawBackgroundForGlyphRange:range atPoint:CGPointZero];
    // Glyphs字形
    [self.textLayoutManager drawGlyphsForGlyphRange:range atPoint:CGPointZero];
    
}

/** 准备文本系统 */
- (void)prepareTextSystem {
    // 打开交互 (Label默认不能交互)
    self.userInteractionEnabled = YES;
    // 准备文本内容
    // 调用顺序: init --> 设置属性(text/attributeText),所以初始化调用prepareTextContent时,attributeText和text均为nil
    // 重写text和attributedText属性中,需要重新准备文本内容
    [self prepareTextContent];
    // 设置对象的关系
    [self.textStorage addLayoutManager:self.textLayoutManager];
    [self.textLayoutManager addTextContainer:self.textLayoutContainer];
}

/** 正则表达式匹配URL */
- (NSArray <NSValue *>*)getUrlsRanges {
    // 正则表达式
    //@"@[\\u4e00-\\u9fa5a-zA-Z0-9_-]*" -> @
    NSString *pattern = @"[a-zA-Z]*://[a-zA-Z0-9/\\.]*";
    // 多重匹配
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:NULL];
    NSMutableArray *rangeArr = [NSMutableArray array];
    NSArray<NSTextCheckingResult *> *matchResults = [regularExpression matchesInString:self.textStorage.string options:0 range:NSMakeRange(0, self.textStorage.length)];
    // 遍历数组,生成Range的数组
    for (NSTextCheckingResult *textCheckingResult in matchResults) {
        
        [rangeArr addObject:[NSValue valueWithRange:textCheckingResult.range]];
    }
    
    return rangeArr.copy;
}

/** 正则表达式匹配@ */
- (NSArray <NSValue *>*)getAtRanges {
    // 正则表达式
    NSString *pattern = @"@[\\u4e00-\\u9fa5a-zA-Z0-9_-]*";
    // 多重匹配
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:NULL];
    NSMutableArray *rangeArr = [NSMutableArray array];
    NSArray<NSTextCheckingResult *> *matchResults = [regularExpression matchesInString:self.textStorage.string options:0 range:NSMakeRange(0, self.textStorage.length)];
    // 遍历数组,生成Range的数组
    for (NSTextCheckingResult *textCheckingResult in matchResults) {
        
        [rangeArr addObject:[NSValue valueWithRange:textCheckingResult.range]];
    }
    
    return rangeArr.copy;
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
    // 遍历Range数组 设置URL文字的属性
    for (NSValue *value in [self getUrlsRanges]) {
        NSRange range = value.rangeValue;
        [self.textStorage addAttributes:@{
                                          NSForegroundColorAttributeName : [UIColor redColor],
                                          NSBackgroundColorAttributeName : [UIColor colorWithWhite:0.9 alpha:1.0],
                                          NSUnderlineStyleAttributeName : @(1)
                                          }
                                  range:range];
    }
    // @ 符号
    for (NSValue *value in [self getAtRanges]) {
        NSRange range = value.rangeValue;
        [self.textStorage addAttributes:@{
                                          NSForegroundColorAttributeName : [UIColor purpleColor],
                                          NSBackgroundColorAttributeName : [UIColor colorWithWhite:0.9 alpha:1.0]
                                          }
                                  range:range];
    }
    
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
