//
//  ViewController.m
//  SQL_FMDB
//
//  Created by ShenYj on 16/10/1.
//  Copyright © 2016年 ShenYj. All rights reserved.
//
#import "JSSQLTableViewController.h"
#import "ViewController.h"
#import "JSStudent.h"
#import "JSSQLButton.h"
#import "Masonry.h"
#import "FMDB.h"

typedef NS_ENUM(NSUInteger, SQLMethod) {
    SQLMethodDDL,
    SQLMethodDML,
    SQLMethodDQL
};

static CGFloat const kMargin = 20;
static CGFloat const kLeftMargin = 40;
static CGFloat const kHeight = 44;

@interface ViewController ()

@property (nonatomic) FMDatabase *dataBase;
@property (nonatomic) JSSQLButton *creat_Table_DDL;
@property (nonatomic) JSSQLButton *drop_Table_DDL;
@property (nonatomic) JSSQLButton *insert_DML;
@property (nonatomic) JSSQLButton *delete_DML;
@property (nonatomic) JSSQLButton *update_DML;
@property (nonatomic) JSSQLButton *query_DQL;
@property (nonatomic) UILabel *result_Label;
@property (nonatomic) JSSQLTableViewController *SQLInfoVC;
@property (nonatomic) NSArray *data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 打开/创建数据库
    [self creatOrOpenDataBase];
    // 准备视图
    [self prepareView];
    
}

- (void)prepareView {
    
    [self.view addSubview:self.creat_Table_DDL];
    [self.view addSubview:self.drop_Table_DDL];
    [self.view addSubview:self.insert_DML];
    [self.view addSubview:self.delete_DML];
    [self.view addSubview:self.update_DML];
    [self.view addSubview:self.query_DQL];
    [self.view addSubview:self.result_Label];
    [self addChildViewController:self.SQLInfoVC];
    [self.view addSubview:self.SQLInfoVC.tableView];
    
    NSArray *ddl = @[self.creat_Table_DDL,self.drop_Table_DDL];
    [ddl mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:kMargin leadSpacing:kLeftMargin tailSpacing:kLeftMargin];
    [ddl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset( 2 * kMargin);
        make.height.mas_equalTo(kHeight);
    }];
    
    NSArray *dml = @[self.insert_DML,self.delete_DML,self.update_DML];
    [dml mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:kMargin leadSpacing:kLeftMargin tailSpacing:kLeftMargin];
    [dml mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.creat_Table_DDL.mas_bottom).mas_offset(kMargin);
        make.height.mas_equalTo(kHeight);
    }];
    
    [self.query_DQL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.creat_Table_DDL);
        make.top.mas_equalTo(self.insert_DML.mas_bottom).mas_offset(kMargin);
        make.size.mas_equalTo(CGSizeMake(80, kHeight));
    }];
    
    [self.result_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.query_DQL.mas_bottom).mas_offset(kMargin);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(80);
    }];
    
    [self.SQLInfoVC.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.result_Label.mas_bottom);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    
    self.data = [self queryData];
}

#pragma mark - 打开创建数据库
- (void)creatOrOpenDataBase {
    
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"dataBase.db"];
    
    self.dataBase = [FMDatabase databaseWithPath:filePath];
    
    [self.dataBase open];
    
}


#pragma mark - 创建表
- (void)creatTable {
   
    NSString *creatSQL = @"CREATE TABLE IF NOT EXISTS T_Student (id integer primary key, name text, age integer)";
    
    BOOL result = [self.dataBase executeUpdate:creatSQL];
    
    if (result) {
        NSLog(@"创建表成功");
        self.result_Label.text = @"创建表成功";
    } else {
        NSLog(@"创建表失败");
        self.result_Label.text = @"创建表失败";
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.result_Label.text = @"展示结果";
    });
    
}

#pragma mark - 删除表
- (void)dropTable {
    
    NSString *dropSQL = @"DROP TABLE T_Student";
    
    BOOL result = [self.dataBase executeUpdate:dropSQL];
    
    if (result) {
        NSLog(@"删除表成功");
        self.result_Label.text = @"删除表成功";
    } else {
        NSLog(@"删除表失败");
        self.result_Label.text = @"删除表失败";
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.result_Label.text = @"展示结果";
    });
    
    
    
}

#pragma mark - 添加数据
- (void)insertData {
    
    NSString *insertSQL = @"INSERT INTO T_Student (name,age) VALUES ('小强',22)";
    
    BOOL result = [self.dataBase executeUpdate:insertSQL];
    
    if (result) {
        NSLog(@"添加数据成功");
        self.result_Label.text = @"添加数据成功";
    } else {
        NSLog(@"添加数据失败");
        self.result_Label.text = @"添加数据失败";
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.result_Label.text = @"展示结果";
    });
    
}


#pragma mark - 删除数据
- (void)deleteData {
    
    NSString *deleteSQL = @"DELETE FROM T_Student WHERE name = '小强'";
    
    BOOL result = [self.dataBase executeUpdate:deleteSQL];
    
    if (result) {
        NSLog(@"删除数据成功");
        self.result_Label.text = @"删除数据成功";
    } else {
        NSLog(@"删除数据失败");
        self.result_Label.text = @"删除数据失败";
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.result_Label.text = @"展示结果";
    });
}
#pragma mark - 修改数据
- (void)updateData {
    
    NSString *updateSQL = @"UPDATE T_Student SET age = 16 WHERE name = '小于'";
    
    BOOL result = [self.dataBase executeUpdate:updateSQL];
    
    if (result) {
        NSLog(@"更新数据成功");
        self.result_Label.text = @"更新数据成功";
    } else {
        NSLog(@"更新数据失败");
        self.result_Label.text = @"更新数据失败";
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.result_Label.text = @"展示结果";
    });
}
#pragma mark - 查询数据
- (NSArray <JSStudent *>*)queryData {
    
    NSMutableArray *mArr = [NSMutableArray array];
    
    NSString *querySQL = @"SELECT * FROM T_Student";
    
    FMResultSet *result = [self.dataBase executeQuery:querySQL];
    
    while ([result next]) {
        
        JSStudent *student = [[JSStudent alloc] init];
        student.name = [result stringForColumn:@"name"];
        student.age = [result stringForColumn:@"age"].integerValue;
        
        [mArr addObject:student];
    }
    
    self.data = mArr.copy;
    self.SQLInfoVC.queryData = mArr.copy;
    
    return mArr.copy;
    
}


#pragma mark
#pragma mark - lazy

- (JSSQLButton *)creat_Table_DDL {
    
    if (_creat_Table_DDL == nil) {
        _creat_Table_DDL = [[JSSQLButton alloc] init];
        [_creat_Table_DDL setTitle:@"creat_Table_DDL" forState:UIControlStateNormal];
        [_creat_Table_DDL addTarget:self action:@selector(creatTable) forControlEvents:UIControlEventTouchUpInside];
    }
    return _creat_Table_DDL;
}

- (JSSQLButton *)drop_Table_DDL {
    
    if (_drop_Table_DDL == nil) {
        _drop_Table_DDL = [[JSSQLButton alloc] init];
        [_drop_Table_DDL setTitle:@"drop_Table_DDL" forState:UIControlStateNormal];
        [_drop_Table_DDL addTarget:self action:@selector(dropTable) forControlEvents:UIControlEventTouchUpInside];
    }
    return _drop_Table_DDL;
}

- (JSSQLButton *)insert_DML {
    
    if (_insert_DML == nil) {
        _insert_DML = [[JSSQLButton alloc] init];
        [_insert_DML setTitle:@"insert_DML" forState:UIControlStateNormal];
        [_insert_DML addTarget:self action:@selector(insertData) forControlEvents:UIControlEventTouchUpInside];
    }
    return _insert_DML;
}

- (JSSQLButton *)delete_DML {
    
    if (_delete_DML == nil) {
        _delete_DML = [[JSSQLButton alloc] init];
        [_delete_DML setTitle:@"delete_DML" forState:UIControlStateNormal];
        [_delete_DML addTarget:self action:@selector(deleteData) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delete_DML;
}

- (JSSQLButton *)update_DML {
    
    if (_update_DML == nil) {
        _update_DML = [[JSSQLButton alloc] init];
        [_update_DML setTitle:@"update_DML" forState:UIControlStateNormal];
        [_update_DML addTarget:self action:@selector(updateData) forControlEvents:UIControlEventTouchUpInside];
    }
    return _update_DML;
}

- (JSSQLButton *)query_DQL {
    
    if (_query_DQL == nil) {
        _query_DQL = [[JSSQLButton alloc] init];
        [_query_DQL setTitle:@"query_DQL" forState:UIControlStateNormal];
        [_query_DQL addTarget:self action:@selector(queryData) forControlEvents:UIControlEventTouchUpInside];
    }
    return _query_DQL;
}

- (UILabel *)result_Label {
    
    if (_result_Label == nil) {
        _result_Label = [[UILabel alloc] init];
        _result_Label.font = [UIFont systemFontOfSize:16];
        _result_Label.textColor = [UIColor purpleColor];
        _result_Label.text = @"展示结果";
        _result_Label.textAlignment = NSTextAlignmentCenter;
        _result_Label.numberOfLines = 0;
        _result_Label.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _result_Label.layer.borderWidth = 2;
    }
    return _result_Label;
}

- (JSSQLTableViewController *)SQLInfoVC {
    
    if (_SQLInfoVC == nil) {
        
        _SQLInfoVC = [[JSSQLTableViewController alloc] initWithStyle:UITableViewStylePlain withData:_data];
        
    }
    return _SQLInfoVC;
}

//- (NSArray <JSStudent *>*)data {
//    
//    if (_data == nil) {
//        _data = [self queryData];
//    }
//    return _data;
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
