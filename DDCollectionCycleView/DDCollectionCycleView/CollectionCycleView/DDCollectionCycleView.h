//
//  DDCollectionCycleView.h
//  AdvancePlan
//
//  Created by 董德帅 on 2020/2/26.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, DDCollectionCycleViewType) {
    DDCollectionCycleViewDefault = 0,//默认样式
    DDCollectionCycleViewScale,//带缩放效果
};

@protocol DDCollectionCycleDelegate <NSObject>

@optional
//点击cell回调
- (void)cycleCollectionView:(UICollectionView *)collectionView didSelectItem:(id)selectItem;
@required
//设置cell
- (nonnull __kindof UICollectionViewCell *)cycleCollectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath ;

@end

@interface DDCollectionCycleView : UICollectionView

@property (nonatomic, assign) DDCollectionCycleViewType cycleViewType;

@property (nonatomic, strong) NSMutableArray *allDataArr;

@property (nonatomic, weak) id<DDCollectionCycleDelegate> cycleDelegate;

@end

NS_ASSUME_NONNULL_END
