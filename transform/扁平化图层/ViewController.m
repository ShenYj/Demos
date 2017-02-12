//
//  ViewController.m
//  扁平化图层
//
//  Created by ShenYj on 2017/2/11.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UIView *greenView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@"123"];
//    NSLog(@"%zd",attr.length);
//    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(0, attr.length)];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(200, 200, 100, 33)];
//    [self.view addSubview:label];
//    label.attributedText = attr;
    
    
    //[self demo1];
    [self demo2];
    
}
/** 
 类似的，当你在玩一个3D游戏，实际上仅仅是把屏幕做了一次倾斜，或许在游戏中可以看见有一面墙在你面前，但是倾斜屏幕并不能够看见墙里面的东西。所有场景里面绘制的东西并不会随着你观察它的角度改变而发生变化；图层也是同样的道理。
 
 这使得用Core Animation创建非常复杂的3D场景变得十分困难。你不能够使用图层树去创建一个3D结构的层级关系--在相同场景下的任何3D表面必须和同样的图层保持一致，这是因为每个的父视图都把它的子视图扁平化了。
 
 至少当你用正常的CALayer的时候是这样，CALayer有一个叫做CATransformLayer的子类来解决这个问题。具体在第六章“特殊的图层”中将会具体讨论。
 */
- (void)demo2 {
    CATransform3D outer = CATransform3DIdentity;
    outer.m34 = -1.0 / 500.0;
    outer = CATransform3DRotate(outer, M_PI_4, 0, 1, 0);
    self.blueView.layer.transform = outer;
    //rotate the inner layer -45 degrees
    CATransform3D inner = CATransform3DIdentity;
    inner.m34 = -1.0 / 500.0;
    inner = CATransform3DRotate(inner, -M_PI_4, 0, 1, 0);
    self.greenView.layer.transform = inner;
}

/** blueView作为greenView的父视图 */
- (void)demo1 {
    // 先将父视图顺时针旋转45°,再将子视图逆时针旋转45°
    CATransform3D outer = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
    self.blueView.layer.transform = outer;
    //rotate the inner layer -45 degrees
    CATransform3D inner = CATransform3DMakeRotation(-M_PI_4, 0, 0, 1);
    self.greenView.layer.transform = inner;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
