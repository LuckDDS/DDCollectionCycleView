//
//  DDCopyAndMutableCopyTest.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/3/23.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDCopyAndMutableCopyTest.h"

@implementation DDCopyAndMutableCopyTest
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)printData{
    NSLog(@"%@",self.strCopy);
}

- (void)printMutableData{
    NSLog(@"%@",self.mutableStrCopy);
}

-(void)changeData{
    self.strCopy = @"123";

}

-(void)changeMutableData{
    [self.mutableStrCopy appendString:@"123123"];
}

@end
