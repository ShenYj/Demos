//
//  ViewController.m
//  果冻效果动画
//
//  Created by ShenYj on 2017/2/26.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "ViewController.h"
#import "BlockView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet BlockView *blockView;
@property (assign,nonatomic) BOOL animating;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)startButtonPressed:(id)sender {
    
    if (self.animating) {
        return;
    }
    
    self.animating = YES;
    
    CGFloat from = CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.blockView.bounds) / 2;
    CGFloat to = 100;
    
    self.blockView.center = CGPointMake(self.blockView.center.x, from);
    
    [self.blockView startAnimationFrom:from to:to];
    
    [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0.85 initialSpringVelocity:0 options:0 animations:^{
        
        self.blockView.center = CGPointMake(self.blockView.center.x, to);
        
    } completion:^(BOOL finished) {
        [self.blockView completeAnimation];
        self.animating = NO;
    }];
}

@end
