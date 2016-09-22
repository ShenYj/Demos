//
//  ViewController.m
//  下拉菜单
//
//  Created by ShenYj on 16/9/22.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "LeftView.h"
#import "RightView.h"
#import "UserNameListTableViewController.h"
#import "PopoverBackGroundView.h"

@interface ViewController () <UIPopoverPresentationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userName_TF;
@property (weak, nonatomic) IBOutlet UITextField *password_TF;
@property (nonatomic) LeftView *leftView_UN;
@property (nonatomic) LeftView *leftView_PW;
@property (nonatomic) RightView *rightView_UN;
@property (nonatomic) RightView *rightView_PW;
@property (nonatomic,strong) UserNameListTableViewController *nameList;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self prepareView];
}

- (void)prepareView {
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.userName_TF.leftView = self.leftView_UN;
    self.userName_TF.leftViewMode = UITextFieldViewModeAlways;
    self.password_TF.leftView = self.leftView_PW;
    self.password_TF.leftViewMode = UITextFieldViewModeAlways;
    self.userName_TF.rightView = self.rightView_UN;
    self.userName_TF.rightViewMode = UITextFieldViewModeAlways;
    self.password_TF.rightView = self.rightView_PW;
    self.password_TF.rightViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:self.leftView_UN];
    [self.leftView_UN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    [self.view addSubview:self.leftView_PW];
    [self.leftView_PW mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    [self.view addSubview:self.rightView_UN];
    [self.rightView_UN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [self.view addSubview:self.rightView_PW];
    [self.rightView_PW mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.rightView_UN setHandler:^(UIButton *button) {
        
        // 设置样式为Popover
        weakSelf.nameList.modalPresentationStyle = UIModalPresentationPopover;
        // 设置尺寸
        weakSelf.nameList.preferredContentSize = CGSizeMake(240, 60);
        
        // 获取Popover对象
        UIPopoverPresentationController *popover = weakSelf.nameList.popoverPresentationController;
        popover.sourceView = button;
        popover.sourceRect = button.bounds;
        
        // 设置自定义的popoverBackgroundViewClass
        popover.popoverBackgroundViewClass = [PopoverBackGroundView class];
        
        // 设置推荐朝向
        popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
        
        // 设置代理,取消自适应
        popover.delegate = weakSelf;
        
        [weakSelf presentViewController:weakSelf.nameList animated:YES completion:nil];
        
    }];
}


#pragma mark - lazy

- (LeftView *)leftView_UN {
    
    if (_leftView_UN == nil) {
        _leftView_UN = [[LeftView alloc] init];
        _leftView_UN.title = @"账号:";
        _leftView_UN.imageName = @"v2_my";
    }
    return _leftView_UN;
}

- (LeftView *)leftView_PW {
    
    if (_leftView_PW == nil) {
        _leftView_PW = [[LeftView alloc] init];
        _leftView_PW.title = @"密码:";
        _leftView_PW.imageName = @"v2_order";
    }
    return _leftView_PW;
}

- (RightView *)rightView_UN {
    
    if (_rightView_UN == nil) {
        _rightView_UN = [[RightView alloc] init];
        _rightView_UN.imageName = @"cell_arrow_down_accessory";
        _rightView_UN.imageNameSel = @"cell_arrow_up_accessory";
        _rightView_UN.buttonType = RightViewButtonTypeUserName;
    }
    return _rightView_UN;
}

- (RightView *)rightView_PW {
    
    if (_rightView_PW == nil) {
        _rightView_PW = [[RightView alloc] init];
        _rightView_UN.buttonType = RightViewButtonTypePassWord;
    }
    return _rightView_PW;
}

- (UserNameListTableViewController *)nameList {
    
    if (_nameList == nil) {
        _nameList = [[UserNameListTableViewController alloc] init];
    }
    return _nameList;
}

#pragma mark - UIAdaptivePresentationControllerDelegate
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    
    return UIModalPresentationNone;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
