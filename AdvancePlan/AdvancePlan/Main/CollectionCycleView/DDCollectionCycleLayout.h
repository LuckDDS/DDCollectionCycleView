//
//  DDCollectionCycleLayout.h
//  AdvancePlan
//
//  Created by 董德帅 on 2020/2/26.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDCollectionCycleLayoutType) {
    
    DDCollectionCycleLayoutDefault = 0,//默认样式,无任何特效
    DDCollectionCycleLayoutScale,//带缩放效果
    
};

@interface DDCollectionCycleLayout : UICollectionViewFlowLayout

/**
 轮播图样式
 */
@property (nonatomic, assign) DDCollectionCycleLayoutType cycleLayoutType;

/**
 cell的放大/缩小基础倍数,控制界面显示的cell的默认大小倍数
 default:0.6
 */
@property (nonatomic, assign) float scaleMultiple;

/**
 cell放大的计算倍数,控制cell最小缩放的倍数
 default:0.6
 */
@property (nonatomic, assign) float scaleMultipleSub;

/**
 左右两个cell的偏移指数,控制cell之间的间距,越小间距越大
 default:0.4,(0-1)
 */
@property (nonatomic, assign) float contentOffsetMutiple;

/**
 控制界面显示的cell的Y轴的坐标
 default:0,(-100 - 100)
 */
@property (nonatomic, assign) float contentOffsetY;

@end

NS_ASSUME_NONNULL_END
