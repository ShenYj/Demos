//
//  JSLoopView.m
//  轮播器demo
//
//  Created by ShenYj on 2016/10/19.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "JSLoopView.h"
#import "JSFlowLayout.h"
#import "JSLoopViewCell.h"

static NSString * const reusedId = @"loopView";

@interface JSLoopView ()

@property (nonatomic) NSTimer *timer;

@property (nonatomic) NSInteger currentIndex;

@end

@implementation JSLoopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame collectionViewLayout:[[JSFlowLayout alloc] init]];
    if (self) {
        
        [self registerClass:[JSLoopViewCell class] forCellWithReuseIdentifier:reusedId];
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor redColor];
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            NSIndexPath *initialIndexPath = [NSIndexPath indexPathForItem:self.imageUrls.count inSection:0];
            [self scrollToItemAtIndexPath:initialIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
            
        });
        
        
        [self startTimer];
    }
    
    return self;
}

- (void)dealloc {
    
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark
#pragma mark - Timer Method

- (void)startTimer {
    
    self.timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(autoChangeNextPage) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)stopTimer {
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)autoChangeNextPage {
    
    
    NSInteger nextIndex = [self indexPathForCell:self.visibleCells.lastObject].item + 1;
    
    if ( nextIndex == [self numberOfItemsInSection:0] ) {
        
        nextIndex = self.imageUrls.count;
    }
    
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextIndex inSection:0];
    
    [self scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}


#pragma mark 
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.imageUrls.count * 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JSLoopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusedId forIndexPath:indexPath];
    
    cell.imageUrlString = self.imageUrls[indexPath.row % self.imageUrls.count];
    cell.currentIndex = indexPath.row % self.imageUrls.count + 1;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //NSLog(@"%f",scrollView.contentOffset.x);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self stopTimer];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self startTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSLog(@"%s",__func__);
    
    NSInteger currentIndex = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    
    if (currentIndex == [self numberOfItemsInSection:0] - 1 ) {
        
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:self.imageUrls.count - 1 inSection:0];
        
        [self scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    if (currentIndex == 0) {
        
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:self.imageUrls.count inSection:0];
        
        [self scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

@end
