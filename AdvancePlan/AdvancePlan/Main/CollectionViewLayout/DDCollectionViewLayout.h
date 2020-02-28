//
//  DDCollectionViewLayout.h
//  AdvancePlan
//
//  Created by 董德帅 on 2020/2/25.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import <UIKit/UIKit.h>
//当前仅适用于一个section的多个section的暂不支持
typedef NS_ENUM(NSInteger,UILayoutAlignment) {
    UILayoutAlignmentDefault = 0,//默认模式左对齐间距自适应
    UILayoutAlignmentLeft,//左对齐,间距一定
    UILayoutAlignmentRight,//右对齐,间距一定
    UILayoutAlignmentCenter,//居中对齐,间距一定
};

NS_ASSUME_NONNULL_BEGIN

@interface DDCollectionViewLayout : UICollectionViewFlowLayout

/**
 设置cell的对齐模式
 */
@property (nonatomic, assign) UILayoutAlignment layoutAlignment;

/**
 设置cell列间距
 默认值10
 */
@property (nonatomic, assign) float interitemSpacing;
@end

NS_ASSUME_NONNULL_END
