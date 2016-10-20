//
//  ViewController.m
//  滚动顶部视图处理练习
//
//  Created by ShenYj on 2016/10/20.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "ViewController.h"
#import "JSHeaderViewController.h"
#import "Masonry.h"

@interface ViewController () 

@property (nonatomic) UILabel *describeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self prepareNavigationBar];
    
    [self.view addSubview:self.describeLabel];
    
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)prepareNavigationBar {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Demo" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBarButtonItem:)];
}

- (void)clickRightBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    JSHeaderViewController *headerVC = [[JSHeaderViewController alloc] init];
    [self.navigationController pushViewController:headerVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UILabel *)describeLabel {
    
    if (_describeLabel == nil) {
        _describeLabel = [[UILabel alloc ]init];
        _describeLabel.textAlignment = NSTextAlignmentCenter;
        _describeLabel.font = [UIFont systemFontOfSize:16];
        _describeLabel.textColor = [UIColor purpleColor];
        _describeLabel.numberOfLines = 0;
        _describeLabel.text = @"点击右上角按钮,进入demo视图";
        
    }
    return _describeLabel;
}


@end
