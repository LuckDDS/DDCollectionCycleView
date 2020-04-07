//
//  DDCopyAndMutableTest.h
//  AdvancePlan
//
//  Created by 董德帅 on 2020/3/23.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DDCopyAndMutableCopyTest;
NS_ASSUME_NONNULL_BEGIN

@interface DDCopyAndMutableTest : NSObject<NSCopying>

@property (nonatomic, copy) NSString * strCopy;
@property (nonatomic, strong) NSString * strStrong;
@property (nonatomic, copy) NSMutableString *mutableStrCopy;
@property (nonatomic, copy) DDCopyAndMutableCopyTest *testCopy;

- (void)printData;
- (void)printTest;
- (void)printStrongData;
- (void)printMutableData;

- (void)changeData;
- (void)changeStrongData;
- (void)changeMutableData;
@end

NS_ASSUME_NONNULL_END
