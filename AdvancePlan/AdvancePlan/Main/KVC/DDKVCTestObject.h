//
//  DDKVCTestObject.h
//  AdvancePlan
//
//  Created by 董德帅 on 2020/4/7.
//  Copyright © 2020 www.dong.com 九天. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DDKVCSubObject;
NS_ASSUME_NONNULL_BEGIN

@interface DDKVCTestObject : NSObject
@property (nonatomic, assign)int objectType;

@property (nonatomic, copy)NSString* objectName;

@property (nonatomic, strong)NSMutableArray* arrAllData;

@property (nonatomic, strong)DDKVCSubObject* subObject;

@property (nonatomic, copy)NSString* userId;

@end

NS_ASSUME_NONNULL_END
