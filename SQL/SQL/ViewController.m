//
//  ViewController.m
//  SQL
//
//  Created by ShenYj on 16/9/30.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "JSSQLTableViewController.h"
#import "ViewController.h"
#import "Masonry.h"
#import "JSSQLButton.h"
#import "JSStudent.h"
#import <sqlite3.h>

static CGFloat const kMargin = 20;
static CGFloat const kLeftMargin = 40;
static CGFloat const kHeight = 44;

@interface ViewController ()
{
    sqlite3 *_db;
}

@property (nonatomic) JSSQLButton *open_DataBase;
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
    
    [self openOrCreatDataBase];
    
    // UI
    [self prepareView];

    
    
}


#pragma mark
#pragma mark - 打开或创建数据库
// 创建或打开数据库
- (void)openOrCreatDataBase {
    
    /*
     创建或打开数据库 ,如果路径代表的数据库不存在,就创建,存在就直接打开
        参数1:数据库的位置
        参数2:数据库的对象地址
     */
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"Database.db"];
    
    // [filePath cStringUsingEncoding:NSUTF8StringEncoding]
    int result = sqlite3_open(filePath.UTF8String, &_db);
    
    
    if (result == SQLITE_OK ) {
        
        NSLog(@"打开数据库成功");
        self.result_Label.text = @"打开数据库成功";
    } else {
        
        NSLog(@"打开数据库失败");
        self.result_Label.text = @"打开数据库失败";
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.result_Label.text = @"展示结果";
    });
    
    
    self.data = [self queryData];
}

#pragma mark - 创建表
- (void)creatTable {
    /*
     创建表
        参数1:数据库对象
        参数2:执行的SQL语句
        参数3:执行SQL语句的回调函数的指针,一般我们穿NULL
        参数4:就是给参数3的参数,执行回调方法需要一些参数,就用参数4来便是
        参数5:如果执行SQL语句出错,就会有错误信息
     
     */
    
    NSString *creatTableSQL = @"CREATE TABLE IF NOT EXISTS T_Student(id integer primary key,name text,age integer)";
    char *error = NULL;
    sqlite3_exec(_db, creatTableSQL.UTF8String, NULL, NULL, &error);
    
    if (error == NULL) {
        
        NSLog(@"创建表成功");
        self.result_Label.text = @"创建表成功";
        
    } else {
        
        NSLog(@"创建失败:%s",error);
        self.result_Label.text = [NSString stringWithFormat:@"创建失败:%@",[NSString stringWithUTF8String:error]];

    }
    
}
#pragma mark - 删除表
- (void)dropTable {
    
    NSString *dropSQL = @"DROP TABLE T_Student";
    
    char *error;
    
    sqlite3_exec(_db, dropSQL.UTF8String, NULL, NULL, &error);
    
    if (error == NULL) {
        
        NSLog(@"删除表成功");
        self.result_Label.text = @"删除表成功";
        
    } else {
        
        NSLog(@"删除表失败:%s",error);
        self.result_Label.text = [NSString stringWithFormat:@"删除表失败:%@",[NSString stringWithUTF8String:error]];
        
    }
    
    
}

#pragma mark - 添加数据
- (void)insertData {
    
    NSString *insertSQL = @"INSERT INTO T_Student(name,age) VALUES ('小李',18)";
    
    char *error;
    
    sqlite3_exec(_db, insertSQL.UTF8String, NULL, NULL, &error);
    
    if (error == NULL) {
        
        NSLog(@"插入数据成功");
        self.result_Label.text = @"插入数据成功";
    } else {
        
        NSLog(@"插入数据失败:%@",[NSString stringWithUTF8String:error]);
        self.result_Label.text = [NSString stringWithFormat:@"插入数据失败:%@",[NSString stringWithUTF8String:error]];
    }
    
}


#pragma mark - 删除数据
- (void)deleteData {
    
    NSString *deleteSQL = @"DELETE FROM T_Student WHERE NAME = '小苍'";
    
    char *error = NULL;
    
    sqlite3_exec(_db, deleteSQL.UTF8String, NULL, NULL, &error);
    
    if (error == NULL) {
        
        NSLog(@"删除数据成功");
        self.result_Label.text = @"删除数据成功";
    } else {
        NSLog(@"删除数据失败:%@",[NSString stringWithUTF8String:error]);
        self.result_Label.text = [NSString stringWithFormat:@"删除数据失败:%@",[NSString stringWithUTF8String:error]];
    }
}
#pragma mark - 修改数据
- (void)updateData {
    
    //NSString *updateSQL = @"UPDATE T_Student SET age = 19 WHERE NAME = '小刘'";
    NSString *updateSQL = @"UPDATE T_Student SET name = '小' WHERE id = 9";
    
    char *error = NULL;
    
    sqlite3_exec(_db, updateSQL.UTF8String, NULL, NULL, &error);
    
    if (error == NULL) {
        NSLog(@"更新数据成功");
        self.result_Label.text = @"更新数据成功";
    } else {
        NSLog(@"更新数据失败:%@",[NSString stringWithUTF8String:error]);
        self.result_Label.text = [NSString stringWithFormat:@"更新数据失败:%@",[NSString stringWithUTF8String:error]];
    }
}
#pragma mark - 查询数据
- (NSArray <JSStudent *>*)queryData {
    
    NSMutableArray *mArr = [NSMutableArray array];
    
    NSString *querySQL = @"SELECT * FROM T_Student";
    
    /*
        原声查询数据用sqlite3_prepare_v2
            参数1:数据库对象
            参数2:要执行的SQL语句
            参数3:SQL语句的长度,一般穿-1,标识让系统自动计算
            参数4:sqlite3_stmt 查询出来的数据就存放在这个对象中
            参数5:尾巴,一般传NULL
     
     */
    sqlite3_stmt *stmt;
    
    int result = sqlite3_prepare_v2(_db, querySQL.UTF8String, -1, &stmt, NULL);
    
    if (result == SQLITE_OK ) {
        
        // 从stmt中每取出一条数据,成功就返回SQLITE_ROW
        while (sqlite3_step(stmt) == SQLITE_ROW ) {
            
            const unsigned char *name = sqlite3_column_text(stmt, 1);
            int age = sqlite3_column_int(stmt, 2);
            
            NSString *name_OC = [NSString stringWithUTF8String:name];
            NSInteger age_OC = @(age).integerValue;
            
            JSStudent *studen = [[JSStudent alloc] init];
            studen.name = name_OC;
            studen.age = age_OC;
            
            [mArr addObject:studen];
            
        }
        
    } else {
        
        NSLog(@"查询失败");
        self.result_Label.text = @"查询失败";
        
    }
    
    self.SQLInfoVC.queryData = mArr.copy;
    
    return mArr.copy;
    
}



#pragma mark - set up UI

- (void)prepareView {
    
    [self.view addSubview:self.open_DataBase];
    [self.view addSubview:self.creat_Table_DDL];
    [self.view addSubview:self.drop_Table_DDL];
    [self.view addSubview:self.insert_DML];
    [self.view addSubview:self.delete_DML];
    [self.view addSubview:self.update_DML];
    [self.view addSubview:self.query_DQL];
    [self.view addSubview:self.result_Label];
    
    [self addChildViewController:self.SQLInfoVC];
    [self.view addSubview:self.SQLInfoVC.tableView];
    
    [self.open_DataBase mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(80);
        make.left.mas_equalTo(self.view).mas_offset(kLeftMargin);
        make.size.mas_equalTo(CGSizeMake(120, kHeight));
    }];
    
    NSArray *ddl = @[self.creat_Table_DDL,self.drop_Table_DDL];
    [ddl mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:kMargin leadSpacing:kLeftMargin tailSpacing:kLeftMargin];
    [ddl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.open_DataBase.mas_bottom).mas_offset(kMargin);
        make.height.mas_equalTo(kHeight);
    }];
    
    NSArray *dml = @[self.insert_DML,self.delete_DML,self.update_DML];
    [dml mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:kMargin leadSpacing:kLeftMargin tailSpacing:kLeftMargin];
    [dml mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.creat_Table_DDL.mas_bottom).mas_offset(kMargin);
        make.height.mas_equalTo(kHeight);
    }];
    
    [self.query_DQL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.open_DataBase);
        make.top.mas_equalTo(self.insert_DML.mas_bottom).mas_offset(kMargin);
        make.size.mas_equalTo(self.open_DataBase);
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
    
    
}
#pragma mark
#pragma mark - lazy

- (JSSQLButton *)open_DataBase {
    
    if (_open_DataBase == nil) {
        _open_DataBase = [[JSSQLButton alloc] init];
        [_open_DataBase setTitle:@"open_DataBase" forState:UIControlStateNormal];
        [_open_DataBase addTarget:self action:@selector(openOrCreatDataBase) forControlEvents:UIControlEventTouchUpInside];
    }
    return _open_DataBase;
}

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


- (NSArray <JSStudent *>*)data {
    
    if (_data == nil) {
        _data = [self queryData];
    }
    return _data;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
