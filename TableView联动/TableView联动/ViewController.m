//
//  ViewController.m
//  TableView联动
//
//  Created by ShenYj on 16/8/18.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"
#import "JSMenumTableView.h"
#import "JSDetailTableView.h"
#import "JSUIkitExtension.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController{
    
    JSMenumTableView     *_menumView;   // 左侧菜单
    JSDetailTableView    *_detailView;  // 右侧详情
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareView];
}


- (void)prepareView{
    
    self.view.backgroundColor = [UIColor js_randomColor];
    
    // 设置左侧菜单视图
    _menumView = [[JSMenumTableView alloc] initWithStyle:UITableViewStyleGrouped];
    
    [self addChildViewController:_menumView];
    [self.view addSubview:_menumView.view];
    
    [_menumView.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self.view);
        make.width.mas_equalTo(100);
    }];
    
    // 设置右侧详情视图
    
    
}


@end
