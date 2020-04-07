//
//  DDSingleton.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/3/21.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDSingleton.h"

@implementation DDSingleton
{
    
}
static DDSingleton * singleton;
+ (id)instance{
    if (!singleton) {
        NSLog(@"%@",@"123123");
        singleton = [[DDSingleton alloc]init];
    }
    return singleton;
}

- (instancetype)init
{
    NSLog(@"qwertyuio");
    self = [super init];
    if (self) {
    }
    return self;
}

@end
