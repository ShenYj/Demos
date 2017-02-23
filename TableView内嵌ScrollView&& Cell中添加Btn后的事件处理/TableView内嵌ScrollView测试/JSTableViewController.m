//
//  JSTableViewController.m
//  TableView内嵌ScrollView测试
//
//  Created by ShenYj on 2017/2/20.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSTableViewController.h"
#import "TableViewCell.h"

static NSString * const reuseIdentifier = @"reuseIdentifier";

static NSString * const footerReuseIdentifier = @"footerReuseIdentifier";

@interface JSTableViewController ()

@property (nonatomic,strong) UIScrollView *footerScrollView;
@property (nonatomic,strong) UITableView *footerTableView;
// 点中屏幕中的点
@property (nonatomic,assign) CGPoint currentPoint;

@end

@implementation JSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self setupUI];
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    [self.footerTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:footerReuseIdentifier];
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    //UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    //[footerView addSubview:self.footerScrollView];
    //self.tableView.tableFooterView = footerView;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    [self.tableView.tableFooterView addSubview:self.footerTableView];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickBtnInCell:(UIButton *)btn {
    
    btn.selected = !btn.isSelected;
    btn.userInteractionEnabled = NO;
    NSLog(@"%s",__func__);
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 1001) {
        return 5;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 1001) {
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:footerReuseIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor purpleColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"TableViewController的tableView的尾部视图中添加的TableView的Cell";
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"TableViewConroller的tableView的Cell";
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(250, 50, 100, 44)];
    btn.backgroundColor = [UIColor greenColor];
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [btn addTarget:self action:@selector(clickBtnInCell:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:btn];
    
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 1001) {
        return 44;
    }
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSLog(@"%s",__func__);
}


#pragma mark
#pragma mark - lazy

- (UIScrollView *)footerScrollView {
    if (!_footerScrollView) {
        _footerScrollView = [[UIScrollView alloc] init];
        _footerScrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
        _footerScrollView.backgroundColor = [UIColor yellowColor];
        _footerScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*3, 300);
    }
    return _footerScrollView;
}

- (UITableView *)footerTableView {
    if (!_footerTableView) {
        _footerTableView = [[UITableView alloc] init];
        _footerTableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
        _footerTableView.tag = 1001;
        _footerTableView.dataSource = self;
        _footerTableView.delegate = self;
    }
    return _footerTableView;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
