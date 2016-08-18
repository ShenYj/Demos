//
//  NSString+JSExtension.h
//  MajorForum
//
//  Created by ShenYj on 16/8/17.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Characters)

/**
 *  将汉字转换为拼音(无音标)
 */
- (instancetype)js_pinyinOfString;

/**
 *  返回不带空格的拼音(无音标)
 */
- (instancetype)js_pinyinWithoutBlankOfString;

/**
 *  汉字转换为拼音后，返回大写的首字母
 */
- (instancetype)js_firstCharacterOfString;

@end
