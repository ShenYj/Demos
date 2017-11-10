//
//  ViewController.m
//  常驻线程Demo
//
//  Created by ShenYj on 2016/12/30.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong) NSThread * thread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadBegin2) object:nil];
    self.thread.name =@"不死线程";
    [self.thread start];
    
}

// threadBegin123 都可以让线程不死
- (void)threadBegin1 {
    @autoreleasepool{ //必须的,下面两个方法也应该加上,处理一些autorelease对象
        [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
        NSLog(@"threadBegin");//主句代码不会执行了,因为[[NSRunLoopcurrentRunLoop] run]一直在跑圈,在RunLoop内部会不断去查看该线程有没有任务要处理,若有,就让它处理一下
        
    }
    
}
- (void)threadBegin2 {
    while (1) {
        [[NSRunLoop currentRunLoop] run];
    }
}
- (void)threadBegin3 {
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(test)userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] run];
    
}

// 自定义的一些任务给该线程执行
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
}

- (void)test {
    NSLog(@"***********test2*******%@", [NSThread currentThread]);
    // NSLog(@"%@", [NSRunLoop currentRunLoop]);
}



@end
