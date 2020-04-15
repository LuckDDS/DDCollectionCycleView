//
//  DDKVCTestObject.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/4/7.
//  Copyright © 2020 www.dong.com 九天. All rights reserved.
//

#import "DDKVCTestObject.h"

@implementation DDKVCTestObject

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"报错KEY:%@",key);
    if ([key isEqualToString:@"id"]) {
        self.userId = value;
    }
}

@end
