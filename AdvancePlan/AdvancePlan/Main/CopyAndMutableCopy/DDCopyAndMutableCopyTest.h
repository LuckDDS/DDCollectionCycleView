//
//  DDCopyAndMutableCopyTest.h
//  AdvancePlan
//
//  Created by 董德帅 on 2020/3/23.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDCopyAndMutableCopyTest : NSObject

@property (nonatomic, copy) NSString * strCopy;
@property (nonatomic, copy) NSMutableString *mutableStrCopy;
- (void)printData;
- (void)printMutableData;

- (void)changeData;
- (void)changeMutableData;

@end

NS_ASSUME_NONNULL_END
