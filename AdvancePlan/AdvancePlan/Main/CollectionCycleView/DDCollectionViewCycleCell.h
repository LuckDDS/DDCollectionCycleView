//
//  DDCollectionViewCycleCell.h
//  AdvancePlan
//
//  Created by 董德帅 on 2020/2/26.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDCollectionViewCycleCell : UICollectionViewCell
- (void)reloadLabelContent:(NSDictionary *)content andIndexPathRow:(NSInteger)indexPathRow;

@end

NS_ASSUME_NONNULL_END
