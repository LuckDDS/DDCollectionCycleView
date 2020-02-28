//
//  DDCollectionCycleView.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/2/26.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDCollectionCycleView.h"
#import "DDCollectionViewCycleCell.h"

@interface DDCollectionCycleView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@end
@implementation DDCollectionCycleView
{
    NSMutableSet *mutableSet;
    float screenWidth;
}
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        mutableSet = [[NSMutableSet alloc]init];
        screenWidth = frame.size.width;
        [self buildConfig];
        [self buildUI];
        
    }
    return self;
}

- (void)buildUI{

    [self registerClass:[DDCollectionViewCycleCell class] forCellWithReuseIdentifier:@"cycleItem"];
    
}

- (void)setAllDataArr:(NSMutableArray *)allDataArr{
    if (allDataArr.count > 0) {
        _allDataArr = allDataArr;
        [_allDataArr addObject:allDataArr[0]];
        [_allDataArr addObject:allDataArr[1]];
        [_allDataArr insertObject:allDataArr[allDataArr.count - 3] atIndex:0];
        [_allDataArr insertObject:allDataArr[allDataArr.count - 4] atIndex:0];
        
        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:3 inSection:0] atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:NO];
    }
}

#pragma delegate
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell;
    if ([self.cycleDelegate respondsToSelector:@selector(cycleCollectionView:cellForItemAtIndexPath:)]) {
        cell = [self.cycleDelegate cycleCollectionView:collectionView cellForItemAtIndexPath:indexPath];
        return cell;
    }else{
        return nil;
    }
    
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.allDataArr.count;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.cycleDelegate respondsToSelector:@selector(cycleCollectionView:didSelectItem:)]) {
        [self.cycleDelegate cycleCollectionView:collectionView didSelectItem:self.allDataArr[indexPath.row]];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //获取collectionview的偏移量
    float scrollOffset = scrollView.contentOffset.x;
    //实现无限循环,当collectionview的偏移量到达某点是改变其偏移量
    if (scrollOffset < screenWidth * 2) {
        
        [self setContentOffset:CGPointMake((self.allDataArr.count-2)*screenWidth, 0) animated:NO];
        
    }
    
    if (scrollOffset > (self.allDataArr.count -2)*screenWidth) {
        
        [self setContentOffset:CGPointMake(screenWidth*2, 0) animated:NO];

    }
    
}

- (void)buildConfig{
    
    self.pagingEnabled = YES;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.delegate = self;
    self.dataSource = self;
    self.decelerationRate = UIScrollViewDecelerationRateFast;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
