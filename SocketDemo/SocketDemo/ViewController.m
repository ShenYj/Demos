//
//  ViewController.m
//  SocketDemo
//
//  Created by ecg on 2017/10/20.
//  Copyright © 2017年 Auko. All rights reserved.
//

#import "ViewController.h"
#import "JSWebSocketManager.h"


#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define TestUserID @"680"

@interface ViewController ()

- (IBAction)open_btn:(UIButton *)sender;
- (IBAction)close_btn:(UIButton *)sender;

@property (nonatomic,strong) JSWebSocketManager *webSocketManager;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(receivedSercerDataNotification:)
                                                 name: kJSWebSocketToolManagerReceivedServerDataNofificationKey
                                               object: nil];
}


#pragma mark - NSNotification
- (void)receivedSercerDataNotification:(NSNotification *)notification
{
    [self addMessageIntoView];
}

#pragma mark - barrage
- (void)addMessageIntoView
{
    CGFloat cooridinateYOffsetMax = ScreenH - 400 - 30;
    CGFloat cooridinateY = arc4random() % (int)cooridinateYOffsetMax + 400;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW, cooridinateY, 120, 30)];
    label.text = @"推送数据 +1";
    label.textColor = [self randomColour];
    [self.view addSubview:label];
    
//    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
//    CGPoint original = label.frame.origin;
//    basicAnimation.fromValue = [NSValue valueWithCGPoint:original];
//    original.x = -120;
//    basicAnimation.toValue = [NSValue valueWithCGPoint:original];
//    basicAnimation.duration = 3;
//    basicAnimation.removedOnCompletion = YES;
//    basicAnimation.fillMode = kCAFillModeForwards;
//    [label.layer addAnimation:basicAnimation forKey:nil];
    
    [UIView animateWithDuration:5 animations:^{
        label.frame = CGRectMake(-120, cooridinateY, 120, 30);
    } completion:^(BOOL finished) {
        if (finished) {
            [label removeFromSuperview];
        }
    }];
}
- (UIColor *)randomColour
{
    CGFloat red = arc4random() % 256;
    CGFloat green = arc4random() % 256;
    CGFloat blue = arc4random() % 256;
    return [UIColor colorWithRed: red / 255.0 green: green / 255.0 blue: blue / 255.0 alpha:1.0];
}

#pragma mark - target
- (IBAction)open_btn:(UIButton *)sender
{
    NSLog(@"%s",__func__);
    NSString *dataString = [NSString stringWithFormat:@"SUBSCRIBE:%@",TestUserID];
    self.webSocketManager = [[JSWebSocketManager alloc] init];
    [self.webSocketManager js_WebSocket_open];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.webSocketManager js_WebSocket_sendData:dataString];
    });
}

- (IBAction)close_btn:(UIButton *)sender
{
    NSLog(@"%s",__func__);
    [self.webSocketManager js_WebSocket_close];
}


@end
