//
//  DetailViewController.h
//  关键帧动画
//
//  Created by ShenYj on 2016/10/7.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

