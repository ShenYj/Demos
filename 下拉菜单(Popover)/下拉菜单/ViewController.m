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
#import "UserNameListTableViewController.h"
#import "PopoverBackGroundView.h"


@interface ViewController () <UIPopoverPresentationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userName_TF;
@property (weak, nonatomic) IBOutlet UITextField *password_TF;
@property (nonatomic) LeftView *leftView_UN; // 账号输入框左侧视图
@property (nonatomic) LeftView *leftView_PW; // 密码输入框左侧视图
@property (nonatomic) UIView *border_UN;     // 账号输入框外边框
@property (nonatomic) UIView *border_PW;     // 密码输入框外边框
@property (nonatomic) UIButton *userNameListButton; // 显示账号列表
@property (nonatomic) UIButton *showPassWordButton; // 显示密码明文
@property (nonatomic,strong) UserNameListTableViewController *nameList; // 列表视图控制器
@property (nonatomic) UILabel *detailLabel;                      // 描述文本框

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self prepareView];
}

- (void)prepareView {
    
    self.view.backgroundColor = [UIColor orangeColor];
    //self.nameList.tableView.hidden = YES;
    
    self.userName_TF.borderStyle = UITextBorderStyleNone;
    self.userName_TF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.userName_TF.secureTextEntry = NO;
    self.password_TF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.password_TF.borderStyle = UITextBorderStyleNone;
    self.password_TF.secureTextEntry = YES;
    
    // 设置TextField的左右视图
    self.userName_TF.leftView = self.leftView_UN;
    self.userName_TF.leftViewMode = UITextFieldViewModeAlways;
    self.password_TF.leftView = self.leftView_PW;
    self.password_TF.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:self.leftView_UN];
    [self.view addSubview:self.leftView_PW];
    [self.view addSubview:self.detailLabel];
    [self.view insertSubview:self.border_UN belowSubview:self.userName_TF];
    [self.view insertSubview:self.border_PW belowSubview:self.password_TF];
    [self.border_UN addSubview:self.userNameListButton];
    [self.border_PW addSubview:self.showPassWordButton];
    
    [self.leftView_UN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    [self.leftView_PW mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
    [self.border_UN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.userName_TF).mas_offset(-2);
        make.bottom.mas_equalTo(self.userName_TF).mas_offset(2);
        make.right.mas_equalTo(self.userName_TF).mas_offset(32);
    }];
    
    [self.border_PW mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.password_TF).mas_offset(-2);
        make.bottom.mas_equalTo(self.password_TF).mas_offset(2);
        make.right.mas_equalTo(self.password_TF).mas_offset(32);
    }];
    
    [self.userNameListButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(self.border_UN);
        make.width.mas_equalTo(30);
    }];
    [self.showPassWordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(self.border_PW);
        make.width.mas_equalTo(30);
    }];
    
    
    __weak typeof(self) weakSelf = self;
    [self.nameList setSelectedHandler:^(NSString *userName) {
        
        weakSelf.userName_TF.text = userName;
        [weakSelf dismissViewControllerAnimated:NO completion:^{
            
            weakSelf.userNameListButton.selected = NO;
            
            
        }];
               
    }];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        
        CGPoint point = [touch locationInView:self.view];
        
        // 当点击屏幕的点不在账号框内时
        if ( !CGRectContainsPoint(self.userName_TF.frame, point) ) {
            
            [self.userName_TF resignFirstResponder];
            
            // 当展开账户列表情况下(列表显示状态),点击屏幕后
            if (!self.nameList.tableView.isHidden) {
                
                [self clickButton:self.userNameListButton];
            }
            
        } else {
            
            //点击屏幕后,如果点在账号输入框内时
            if ( !self.nameList.tableView.isHidden) {
                
                [self clickButton:self.userNameListButton];
            }
            
        }
        
        // 当点击屏幕的点不在密码框内时
        if (!CGRectContainsPoint(self.password_TF.frame, point)) {
            
            [self.password_TF resignFirstResponder];
        }
        
        
    }
    
    
}


#pragma mark - target

- (void)clickButton:(UIButton *)sender {
    
    sender.selected = !sender.isSelected;

    if (sender.tag == 1001) {
        
        // password
        self.password_TF.secureTextEntry = !sender.selected;
        
    } else {
        
        // username
        self.nameList.tableView.hidden = !sender.isSelected;
        
        //设置样式为Popover
        self.nameList.modalPresentationStyle = UIModalPresentationPopover;
        
        // 设置尺寸 (在设置TextField最外层的View时,左右分别设置了2个单位的间距)
        self.nameList.preferredContentSize = CGSizeMake(self.userName_TF.bounds.size.width + 34, 60);
        
        // 获取Popover对象
        UIPopoverPresentationController *popover = self.nameList.popoverPresentationController;
        
        // 设置来源视图 (这里将TextField外层的View作为来源视图)
        //popover.sourceView = sender;
        popover.sourceView = self.border_UN;
        
        
        // 设置锚点 (这里将TextField外层的View作为锚点)
        //popover.sourceRect = sender.bounds;
        popover.sourceRect = CGRectMake(0, 0, self.border_UN.bounds.size.width, self.border_UN.bounds.size.height);
        
        // 设置自定义的popoverBackgroundViewClass
        popover.popoverBackgroundViewClass = [PopoverBackGroundView class];
        
        // 设置推荐朝向
        popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
        
        // 设置代理,取消自适应
        popover.delegate = self;
        
        // 以Popover样式进行Modal展示
        [self presentViewController:self.nameList animated:YES completion:nil];
        
    }
    
}


#pragma mark - UIAdaptivePresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    
    return UIModalPresentationNone;
}


#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    if ([textField isEqual:self.userName_TF]) {
        
        if (range.location > 9) {
            return NO;
        }
        
    } else {
        
        if (range.location > 11) {
            return NO;
        }
    }
    
    return YES;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [textField becomeFirstResponder];
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

- (UIButton *)userNameListButton {
    
    if (_userNameListButton == nil) {
        _userNameListButton = [[UIButton alloc] init];
        _userNameListButton.tag = 1002;
        [_userNameListButton setImage:[UIImage imageNamed:@"cell_arrow_down_accessory"] forState:UIControlStateNormal];
        [_userNameListButton setImage:[UIImage imageNamed:@"cell_arrow_up_accessory"] forState:UIControlStateSelected];
        [_userNameListButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userNameListButton;
}

- (UIButton *)showPassWordButton {
    
    if (_showPassWordButton == nil) {
        _showPassWordButton = [[UIButton alloc] init];
        _showPassWordButton.tag = 1001;
        [_showPassWordButton setImage:[UIImage imageNamed:@"icon_black_scancode"] forState:UIControlStateNormal];
        [_showPassWordButton setImage:[UIImage imageNamed:@"scanicon"] forState:UIControlStateSelected];
        [_showPassWordButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showPassWordButton;
}

- (UserNameListTableViewController *)nameList {
    
    if (_nameList == nil) {
        _nameList = [[UserNameListTableViewController alloc] init];
    }
    return _nameList;
}

- (UIView *)border_UN {
    
    if (_border_UN == nil) {
        _border_UN = [[UIView alloc] init];
        _border_UN.layer.borderWidth = 1;
        _border_UN.backgroundColor = [UIColor whiteColor];
        _border_UN.layer.borderColor = [UIColor grayColor].CGColor;
    }
    return _border_UN;
}

- (UIView *)border_PW {
    
    if (_border_PW == nil) {
        _border_PW = [[UIView alloc] init];
        _border_PW.layer.borderWidth = 1;
        _border_PW.backgroundColor = [UIColor whiteColor];
        _border_PW.layer.borderColor = [UIColor grayColor].CGColor;
    }
    return _border_PW;
}

- (UILabel *)detailLabel {
    
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize:13];
        _detailLabel.textColor = [UIColor purpleColor];
        _detailLabel.numberOfLines = 0;
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.text = @"自定义UITextField的LeftView和RightView\n没有对应的图片所以随便设置的\n账号列表使用的是Popover进行实现";
    }
    return _detailLabel;
}



@end
