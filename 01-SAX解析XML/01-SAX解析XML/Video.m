//
//  Video.m
//  10-XML解析
//
//  Created by Apple on 15/12/11.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import "Video.h"

@implementation Video

- (NSString *)description{
    return [NSString stringWithFormat:@"%@---%@-%@-%@-%@--%@---%@",_videoId,_name,_length,_imageURL,_videoURL,_teacher,_desc];
}

@end
