//
//  JSLayerLabel.m
//  transform
//
//  Created by ShenYj on 2017/2/12.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSLayerLabel.h"
#import <QuartzCore/QuartzCore.h>

@implementation JSLayerLabel

+ (Class)layerClass {
    //this makes our label create a CATextLayer //instead of a regular CALayer for its backing layer
    // 把CATextLayer作为宿主图层的另一好处就是视图自动设置了contentsScale属性。
    return [CATextLayer class];
}

- (CATextLayer *)textLayer {
    return (CATextLayer *)self.layer;
}

- (void)setUp {
    //set defaults from UILabel settings
    self.text = self.text;
    self.textColor = self.textColor;
    self.font = self.font;
    
    //we should really derive these from the UILabel settings too
    //but that's complicated, so for now we'll just hard-code them
    [self textLayer].alignmentMode = kCAAlignmentJustified;
    [self textLayer].wrapped = YES;
    [self.layer display];
}

- (id)initWithFrame:(CGRect)frame {
    //called when creating label programmatically
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib {
    //called when creating label using Interface Builder
    [super awakeFromNib];
    [self setUp];
}

- (void)setText:(NSString *)text {
    super.text = text;
    //set layer text
    [self textLayer].string = text;
}

- (void)setTextColor:(UIColor *)textColor {
    super.textColor = textColor;
    //set layer text color
    [self textLayer].foregroundColor = textColor.CGColor;
}

- (void)setFont:(UIFont *)font {
    super.font = font;
    //set layer font
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    [self textLayer].font = fontRef;
    [self textLayer].fontSize = font.pointSize;
    CGFontRelease(fontRef);
}

@end
