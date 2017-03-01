//
//  ViewController.m
//  快速排序
//
//  Created by ShenYj on 2017/3/1.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "ViewController.h"
#import "BaseModel.h"

@interface ViewController ()

@property (nonatomic) NSMutableArray <BaseModel *>*foodModels;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self fastSortLeftIndex:0 WithRightIndex:7];
    
    NSLog(@"%@",self.foodModels);
}


//快速排序- 星级评分
- (void)fastSortLeftIndex:(NSInteger)left WithRightIndex:(NSInteger)right
{
    NSInteger i, j;
    if(left > right) return;
    
    BaseModel *tempModel = self.foodModels[left]; //基准模型
    i = left;
    j = right;
    while (i != j) {
        //从右边开始找比基准模型的评分小的模型
        while (i < j && self.foodModels[j].evaluation > tempModel.evaluation) {
            j--;
        }
        //从左向右找
        while (i < j  && self.foodModels[i].evaluation <= tempModel.evaluation) {
            i++;
        }
        //如果左右都找到了就交换模型
        if(i < j)
        {
            BaseModel *model_i = self.foodModels[i];
            BaseModel *model_j = self.foodModels[j];
            
            [self.foodModels replaceObjectAtIndex:i withObject:model_j];
            [self.foodModels replaceObjectAtIndex:j withObject:model_i];
        }
    }
    //如果相遇了
    self.foodModels[left] = self.foodModels[i];
    self.foodModels[i] = tempModel;
    //第一轮结束之后，采用递归 - 二分法
    [self fastSortLeftIndex:left WithRightIndex:i-1];
    [self fastSortLeftIndex:i+1 WithRightIndex:right];
    return;
    //快速排序时间复杂度:N * logN - 所以我比较喜欢快速排序哦
}


#pragma mark
#pragma mark -

- (NSMutableArray<BaseModel *> *)foodModels {
    if (!_foodModels) {
        _foodModels = [NSMutableArray array];
        NSArray *evaluation = @[@12,@32,@5,@70,@33,@25,@50,@40];
        for (int i = 0; i < 8; i ++) {
            BaseModel *baseModel = [[BaseModel alloc] init];
            baseModel.evaluation = [evaluation[i] intValue];
            [_foodModels addObject:baseModel];
        }
    }
    return _foodModels;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
