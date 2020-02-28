//
//  DDCollectionCycleLayout.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/2/26.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDCollectionCycleLayout.h"

@implementation DDCollectionCycleLayout
{
    //屏幕宽
    float screenWidth;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        
    }
    return self;
}

-(void)setScaleMultiple:(float)scaleMultiple{
    
    _scaleMultiple = scaleMultiple;
    
}

- (void)setScaleMultipleSub:(float)scaleMultipleSub{
    
    _scaleMultipleSub = scaleMultipleSub;
    
}

- (void)setContentOffsetMutiple:(float)contentOffsetMutiple{
    
    _contentOffsetMutiple = contentOffsetMutiple;

}

- (void)setContentOffsetY:(float)contentOffsetY{
    _contentOffsetY = contentOffsetY;
}

//获取当前界面的偏移量
- (float)getCollectionViewContentOffsetX{

    return self.collectionView.contentOffset.x;
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    //UICollectionViewLayoutAttributes存储的是cell的布局信息
    
    //获取当前界面rect范围内展示的cell的Attributes
    NSArray *origin = [[super layoutAttributesForElementsInRect:rect] copy];
    //将origin内部的对象全部copy一份到copyArr
    NSArray *copyArr = [[NSArray alloc]initWithArray:origin copyItems:YES];
    NSMutableArray *attributesArr = [NSMutableArray arrayWithArray:copyArr];
    
    if (self.cycleLayoutType == DDCollectionCycleLayoutDefault) {
        
        return attributesArr;
    }
    //获取当前屏幕的款
    screenWidth = self.collectionView.frame.size.width;

    //获取当前collectionview的X坐标的偏移量
    float contentOffsetX = [self getCollectionViewContentOffsetX];
    
    //滑动过程中cell缩小/放大的倍数
    float moveParam = 0;
    
    float attributesX = 0;
    //对当前界面的cell的Attributes进行动画处理
    for (UICollectionViewLayoutAttributes *attributes in attributesArr) {
        
        //下面的这被注释的代码打开会出现斜角滑动的效果
        //CATransform3D transformOffsetX = CATransform3DMakeTranslation(-(attributes.frame.origin.x - contentOffsetX) * _contentOffsetMutiple, -(attributes.frame.origin.x - contentOffsetX) * _contentOffsetMutiple, 0);
        
        //当前cell的X的坐标
        attributesX = attributes.frame.origin.x;

        //cell的左右偏移动画
        CATransform3D transformOffsetX = CATransform3DMakeTranslation(-(attributesX - contentOffsetX) * _contentOffsetMutiple, 0, 0);
        
        //计算cell的缩放的大小
        if ((attributesX - contentOffsetX) >= 0) {
            
            //当前cell的x的坐标比界面的偏移量大,证明当前的cell在当前界面中间或者右侧,计算此时该cell的缩小倍数
            moveParam = fabs((screenWidth - (attributesX - contentOffsetX)) / screenWidth);
            
        }else{
            
            //当前cell的x的坐标比界面的偏移量小,证明当前的cell在当前界面中间或者左侧,计算此时该cell的缩小倍数
            moveParam = fabs((screenWidth + attributesX - contentOffsetX) / screenWidth);
            
        }
        
        
        //添加动画
        if (moveParam <= 1 && moveParam > _scaleMultipleSub) {

            if (_contentOffsetY != 0) {
                //设置cell的上下偏移量
                transformOffsetX.m42 =  (_scaleMultipleSub * 2 - moveParam) * _contentOffsetY - (moveParam-_scaleMultipleSub) * _contentOffsetY;
            }
            
            attributes.zIndex = 3;
            //如果缩放倍数处于scaleMultipleSub和1之间进行缩放倍数的计算
            attributes.transform3D = CATransform3DScale(transformOffsetX, _scaleMultiple * moveParam, _scaleMultiple * moveParam, 1);
            
        }else{
            
            if (_contentOffsetY != 0) {
                //设置cell的上下偏移量
                transformOffsetX.m42 = _scaleMultipleSub * _contentOffsetY;
                
            }

            attributes.zIndex = 0;
            //如果缩放倍数大于1或者小于scaleMultipleSub,此时计算时按默认值计算
            attributes.transform3D = CATransform3DScale(transformOffsetX, _scaleMultiple * _scaleMultipleSub, _scaleMultiple * _scaleMultipleSub, 1);
            
        }
        
        
    }
    
    return [attributesArr copy];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    
    return YES;
}
@end
