//
//  DDCollectionCycleBackView.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/2/28.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDCollectionCycleBackView.h"
#import "DDCollectionCycleLayout.h"
@interface DDCollectionCycleBackView ()<UICollectionViewDataSource,
                                        UICollectionViewDelegate,
                                        UICollectionViewDelegateFlowLayout,
                                        UIScrollViewDelegate>
//轮播图载体
@property (nonatomic, strong) UICollectionView *cycleCollectionView;
//
@property (nonatomic, strong) DDCollectionCycleLayout *cycleCollectionViewLayout;

@end

@implementation DDCollectionCycleBackView
{
    //需要被注册的class
    Class cycleCellClass;
    //屏幕宽
    float screenWidth;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        screenWidth = frame.size.width;
        _contentOffsetY = 0;
        _scaleMultiple = 0.6;
        _scaleMultipleSub = 0.6;
        _contentOffsetMutiple = 0.4;

        
    }
    return self;
}

- (void)buildUI{
    
    [self addSubview:self.cycleCollectionView];
    [_cycleCollectionView registerClass:cycleCellClass forCellWithReuseIdentifier:@"cycleItem"];
    
}

- (void)buildCycleCollectionViewWithShowCellClass:(Class)cellClass{
    
    cycleCellClass = cellClass;
    //构建界面
    [self buildUI];
    //配置界面
    [self buildConfig];
}

- (void)setAllDataArr:(NSMutableArray *)allDataArr{
    
    if (allDataArr.count > 0) {
        
        _allDataArr = allDataArr;
        [_allDataArr addObject:allDataArr[0]];
        [_allDataArr addObject:allDataArr[1]];
        [_allDataArr insertObject:allDataArr[allDataArr.count - 3] atIndex:0];
        [_allDataArr insertObject:allDataArr[allDataArr.count - 4] atIndex:0];
        
        [_cycleCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0] atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:NO];
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
        
        [_cycleCollectionView setContentOffset:CGPointMake((self.allDataArr.count-2)*screenWidth, 0) animated:NO];
        
    }
    
    if (scrollOffset > (self.allDataArr.count -2)*screenWidth) {
        
        [_cycleCollectionView setContentOffset:CGPointMake(screenWidth*2, 0) animated:NO];
        
    }
    
}

-(void)setContentOffsetY:(float)contentOffsetY{

    _contentOffsetY = contentOffsetY;

}

- (void)setCycleViewType:(DDCollectionCycleViewType)cycleViewType{

    _cycleViewType = cycleViewType;
    
}

-(void)setContentOffsetMutiple:(float)contentOffsetMutiple{
    
    _contentOffsetMutiple = contentOffsetMutiple;
    
}

- (void)setScaleMultiple:(float)scaleMultiple{
    
    _scaleMultiple = scaleMultiple;
    
}

- (void)setScaleMultipleSub:(float)scaleMultipleSub{
 
    _scaleMultipleSub = scaleMultipleSub;
    
}


- (void)buildConfig{
    
    _cycleCollectionView.pagingEnabled = YES;
    _cycleCollectionView.showsVerticalScrollIndicator = NO;
    _cycleCollectionView.showsHorizontalScrollIndicator = NO;
    _cycleCollectionView.delegate = self;
    _cycleCollectionView.dataSource = self;
    _cycleCollectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    
}

/**
 初始话cycleCollectionView
 */
- (UICollectionView *)cycleCollectionView{
    
    if (!_cycleCollectionView) {
        
        _cycleCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:self.cycleCollectionViewLayout];
        _cycleCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _cycleCollectionView.backgroundColor = [UIColor blueColor];
        
    }
    return _cycleCollectionView;
}

/**
 初始话layout
 */
- (DDCollectionCycleLayout *)cycleCollectionViewLayout{
    
    if (!_cycleCollectionViewLayout) {
        
        _cycleCollectionViewLayout = [[DDCollectionCycleLayout alloc]init];
        _cycleCollectionViewLayout.cycleLayoutType = (DDCollectionCycleLayoutType)_cycleViewType;
        _cycleCollectionViewLayout.scaleMultiple = _scaleMultiple;
        _cycleCollectionViewLayout.scaleMultipleSub = _scaleMultipleSub;
        _cycleCollectionViewLayout.contentOffsetMutiple = _contentOffsetMutiple;
        _cycleCollectionViewLayout.contentOffsetY = _contentOffsetY;
        
    }
    return _cycleCollectionViewLayout;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
