//
//  ViewController.m
//  TextKitDemo
//
//  Created by ShenYj on 2016/11/25.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "ViewController.h"
#import <SafariServices/SafariServices.h>
#import "JSTextLabel.h"

@interface ViewController () <JSTextLabelDelegate>

@property (nonatomic,strong) JSTextLabel *textLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.textLabel];
    
}

#pragma mark
#pragma mark - JSTextLabelDelegate
- (void)textLabel:(JSTextLabel *)textLabel withClickTextStorageString:(NSString *)string {
    SFSafariViewController *sfViewController = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:string]];
    [self presentViewController:sfViewController animated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

#pragma mark
#pragma mark - Lazy

- (JSTextLabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[JSTextLabel alloc] init];
        _textLabel.delegate = self;
        _textLabel.frame = CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, 100);
        _textLabel.text = @"苹果官方网站:http://www.apple.com,使劲戳";
        _textLabel.backgroundColor = [UIColor orangeColor];
    }
    return _textLabel;
}

@end
