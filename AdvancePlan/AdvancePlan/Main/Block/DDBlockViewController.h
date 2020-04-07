//
//  DDBlockViewController.h
//  AdvancePlan
//
//  Created by 董德帅 on 2020/3/13.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDRootViewController.h"
typedef NSString *_Nullable(^typedefBlock)(NSString *_Nullable);
NS_ASSUME_NONNULL_BEGIN

@interface DDBlockViewController : DDRootViewController
@property (nonatomic ,copy)typedefBlock copyBlock;
@property (nonatomic ,strong)typedefBlock strongBlock;

@end

NS_ASSUME_NONNULL_END
