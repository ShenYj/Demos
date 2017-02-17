//
//  ViewController.m
//  CAScrollLayer
//
//  Created by ShenYj on 2017/2/17.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "ViewController.h"
#import "ScrollView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet ScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"IMG_3946"];
    imageView.frame = CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.height);
    [self.scrollView addSubview:imageView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
