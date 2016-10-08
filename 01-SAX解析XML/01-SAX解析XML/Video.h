//
//  Video.h
//  10-XML解析
//
//  Created by Apple on 15/12/11.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
    Strong 相当于Retain ,地址不变,引用技术+1
 
    copy:拷贝一个副本,和原先的没有半毛钱关系
*/

@interface Video : NSObject

@property(nonatomic,copy)NSString *videoId;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *length;

@property(nonatomic,copy)NSString *videoURL;

@property(nonatomic,copy)NSString *imageURL;

@property(nonatomic,copy)NSString *desc;

@property(nonatomic,copy)NSString *teacher;

@end
