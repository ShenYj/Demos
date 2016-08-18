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
    [self.view addSubview:_menumView.tableView];
    
    [_menumView.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self.view);
        make.width.mas_equalTo(150);
    }];
    
    // 设置右侧详情视图
    _detailView = [[JSDetailTableView alloc] initWithStyle:UITableViewStyleGrouped];
    
    [self addChildViewController:_detailView];
    [self.view addSubview:_detailView.tableView];
    
    [_detailView.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_menumView.view.mas_right);
        make.top.right.bottom.mas_equalTo(self.view);
    }];
    
    // 点击MenumView回调
    __weak JSDetailTableView *weakDetailView = _detailView;
    [_menumView setClickMenumCell:^(NSIndexPath *indexPath) {
        
        if (weakDetailView) {
            __strong JSDetailTableView *strongkDetailView = weakDetailView;
            
            [strongkDetailView.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section] animated:YES scrollPosition:UITableViewScrollPositionTop];
        }
        
    }];
    
    // 滚动DetailView回调
    __weak JSMenumTableView *weakMenumView = _menumView;
    [_detailView setScrollDetailCell:^(NSIndexPath *indexPath) {
        
        if (weakMenumView) {
            __strong JSMenumTableView *strongMenumView = weakMenumView;
            [strongMenumView.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }];
    
}


@end
