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

/** 
 快速排序原理解说
 
 有一个队列是 4 6 2 5 1 3 7 用快速排序排序 12345678
 
 首先我们要知道我们要排列的顺序是从小到大，意思就是小的在左边，大的在右边，
 第一轮 ：第一个数为基准数 4
 那么A从左边开始找大于 4 的数，找到之后停止， B从右边开始找小于4的数，（B先开始找，因为基准数在左边），这样当B找到3就停止、A找到6就停止，那么开始交换，交换后的结果4 3 2 5 1 6 7，这个时候第一轮还没有结束，A和B继续找，找到就继续交换，当某一刻事件A和B相遇的时候，那么就不用找了，直接把基准数与相遇的值交换，第一轮结果
 1 3 2 4 5 6 7
 
 后面几步这里我不做解说，大家要自己写一下才能体会，要是全是文字，可能根本没有耐心看完。其实第一轮把数列分成的2组,2组又分别进行第一轮的操作，细心的同学可能发现，其实每一轮都会归位一个数，所以我把这些排序就理解的归位类的。
 
 */


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
